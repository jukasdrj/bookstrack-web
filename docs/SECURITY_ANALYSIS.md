# Security Analysis: BendV3 API → Flutter → Drift

**Date:** January 5, 2026
**Scope:** Data flow from BendV3 API through DTOs to local Drift database

---

## Current Security Posture

### 🔴 Critical Gaps Identified

#### 1. **No Input Validation on API Responses**
**Risk Level:** HIGH

**Current State:**
```dart
// lib/core/services/api/bendv3_service.dart
final results = (data['results'] as List)
    .map((json) => BookResult.fromJson(json as Map<String, dynamic>))
    .toList();
```

**Vulnerabilities:**
- ❌ **No type checking** - Assumes API always returns correct types
- ❌ **No null safety** - Direct casts can throw if data structure changes
- ❌ **No schema validation** - Trusts API response shape implicitly
- ❌ **No size limits** - Can process unlimited results (DoS vector)

**Attack Vectors:**
1. **Malicious API Response:** If BendV3 is compromised, can inject:
   - SQL injection strings in titles/authors
   - XSS payloads in descriptions/notes
   - Oversized data causing memory exhaustion
   - Malformed JSON causing app crashes

2. **Man-in-the-Middle:** Despite HTTPS, if certificate pinning fails:
   - Attacker can modify API responses
   - Inject malicious book data
   - Corrupt local database

---

#### 2. **No Sanitization Before Database Insert**
**Risk Level:** HIGH

**Current State:**
```dart
// lib/core/data/dto_mapper.dart
return WorksCompanion.insert(
  id: dto.id,                    // ❌ No validation
  title: dto.title,              // ❌ No sanitization
  author: Value(authorNames),    // ❌ No sanitization
  description: Value(dto.description), // ❌ XSS risk
);
```

**Vulnerabilities:**
- ❌ **No SQL injection protection** - Drift handles this, but no validation
- ❌ **No XSS sanitization** - Raw HTML in descriptions could be rendered
- ❌ **No length limits** - Can insert 10MB descriptions
- ❌ **No character encoding validation** - Unicode exploits possible

**Attack Scenarios:**
```json
{
  "title": "<script>alert('XSS')</script>",
  "description": "A".repeat(10_000_000),  // 10MB string
  "author": "'; DROP TABLE works; --"
}
```

---

#### 3. **No Error Boundary for Malformed Data**
**Risk Level:** MEDIUM

**Current State:**
```dart
} catch (e) {
  rethrow;  // ❌ Generic rethrow, no context
}
```

**Issues:**
- ❌ **No specific error handling** - All errors treated equally
- ❌ **No logging** - Can't trace source of corruption
- ❌ **No recovery** - App crashes instead of graceful degradation
- ❌ **No user notification** - Silent failures or crashes

---

#### 4. **No Rate Limiting on Database Writes**
**Risk Level:** MEDIUM

**Current State:**
```dart
for (final bookResult in searchResponse.results) {
  await database.transaction(() async {
    // Unlimited inserts
  });
}
```

**Vulnerabilities:**
- ❌ **DoS via large results** - API could return 10,000 books
- ❌ **No throttling** - Can overwhelm Drift with writes
- ❌ **No transaction size limits** - Single transaction can lock DB

---

## What's Currently Protected

### ✅ What Drift Provides (Built-in)

**SQL Injection Prevention:**
```dart
// Drift uses parameterized queries automatically
select(works)..where((w) => w.id.equals(userInput))
// ✅ Compiles to: SELECT * FROM works WHERE id = ?
// ✅ userInput is escaped automatically
```

**Type Safety:**
```dart
// Drift enforces schema at compile time
TextColumn get title => text()();  // ✅ Can only be String
IntColumn get pageCount => integer()();  // ✅ Can only be int
```

**HTTPS (Transport Security):**
```dart
// Dio uses HTTPS by default
static const String _baseUrl = 'https://api.oooefam.net/v3';
// ✅ Encrypted in transit
```

---

## Recommended Security Layers

### Layer 1: API Response Validation (CRITICAL)

**Add response schema validator:**

```dart
// lib/core/services/api/response_validator.dart
class ResponseValidator {
  static const int MAX_RESULTS = 100;
  static const int MAX_STRING_LENGTH = 10000;

  static SearchResponse validateSearchResponse(Map<String, dynamic> json) {
    // 1. Check success flag
    if (json['success'] != true) {
      throw ApiException(
        code: json['error']?['code'] ?? 'UNKNOWN',
        message: json['error']?['message'] ?? 'API request failed',
      );
    }

    // 2. Validate data structure
    final data = json['data'];
    if (data == null || data is! Map<String, dynamic>) {
      throw ApiException(
        code: 'INVALID_RESPONSE',
        message: 'Missing or invalid data field',
      );
    }

    // 3. Validate results array
    final results = data['results'];
    if (results == null || results is! List) {
      throw ApiException(
        code: 'INVALID_RESULTS',
        message: 'Missing or invalid results array',
      );
    }

    // 4. Check size limits
    if (results.length > MAX_RESULTS) {
      throw ApiException(
        code: 'RESULTS_TOO_LARGE',
        message: 'Results exceed maximum of $MAX_RESULTS',
      );
    }

    // 5. Validate each book result
    final validatedResults = results.map((json) {
      return _validateBookResult(json);
    }).toList();

    return SearchResponse(
      results: validatedResults,
      totalCount: data['totalCount'] ?? 0,
    );
  }

  static BookResult _validateBookResult(dynamic json) {
    if (json is! Map<String, dynamic>) {
      throw ApiException(
        code: 'INVALID_BOOK',
        message: 'Book result is not an object',
      );
    }

    // Validate required fields
    _validateField(json, 'work', Map<String, dynamic>);
    _validateField(json, 'authors', List);

    // Validate string lengths
    final work = json['work'] as Map<String, dynamic>;
    _validateStringLength(work['title'], 'title');
    _validateStringLength(work['description'], 'description');

    return BookResult.fromJson(json);
  }

  static void _validateField(Map<String, dynamic> json, String field, Type type) {
    if (!json.containsKey(field)) {
      throw ApiException(
        code: 'MISSING_FIELD',
        message: 'Missing required field: $field',
      );
    }

    if (json[field].runtimeType != type) {
      throw ApiException(
        code: 'INVALID_TYPE',
        message: 'Field $field has wrong type',
      );
    }
  }

  static void _validateStringLength(dynamic value, String field) {
    if (value is String && value.length > MAX_STRING_LENGTH) {
      throw ApiException(
        code: 'STRING_TOO_LONG',
        message: 'Field $field exceeds $MAX_STRING_LENGTH characters',
      );
    }
  }
}
```

**Usage:**
```dart
// lib/core/services/api/bendv3_service.dart
Future<SearchResponse> searchBooks(...) async {
  try {
    final response = await _dio.get(...);

    // ✅ VALIDATE BEFORE PARSING
    return ResponseValidator.validateSearchResponse(response.data!);

  } catch (e) {
    // Log and rethrow with context
    debugPrint('Search failed: $e');
    rethrow;
  }
}
```

---

### Layer 2: Input Sanitization (HIGH PRIORITY)

**Add sanitizer for user-facing strings:**

```dart
// lib/core/utils/sanitizer.dart
class Sanitizer {
  /// Remove HTML tags and dangerous characters
  static String sanitizeText(String? input) {
    if (input == null || input.isEmpty) return '';

    // 1. Remove HTML tags
    String clean = input.replaceAll(RegExp(r'<[^>]*>'), '');

    // 2. Remove dangerous characters
    clean = clean.replaceAll(RegExp(r'[<>"\']'), '');

    // 3. Normalize whitespace
    clean = clean.replaceAll(RegExp(r'\s+'), ' ').trim();

    return clean;
  }

  /// Truncate to max length
  static String truncate(String input, int maxLength) {
    if (input.length <= maxLength) return input;
    return '${input.substring(0, maxLength)}...';
  }

  /// Validate ISBN format
  static String? validateIsbn(String? isbn) {
    if (isbn == null) return null;

    // Remove hyphens and spaces
    final clean = isbn.replaceAll(RegExp(r'[-\s]'), '');

    // Check length (ISBN-10 or ISBN-13)
    if (clean.length != 10 && clean.length != 13) {
      throw FormatException('Invalid ISBN length: ${clean.length}');
    }

    // Check all digits (except last char can be X for ISBN-10)
    if (!RegExp(r'^\d{9}[\dX]$|^\d{13}$').hasMatch(clean)) {
      throw FormatException('Invalid ISBN format: $clean');
    }

    return clean;
  }
}
```

**Usage:**
```dart
// lib/core/data/dto_mapper.dart
static WorksCompanion _mapWorkDTOToCompanion(WorkDTO dto, ...) {
  return WorksCompanion.insert(
    id: dto.id,
    title: Sanitizer.sanitizeText(dto.title),  // ✅ Sanitized
    author: Value(Sanitizer.sanitizeText(authorNames)),  // ✅ Sanitized
    description: Value(Sanitizer.truncate(
      Sanitizer.sanitizeText(dto.description),
      10000,  // Max 10k chars
    )),
  );
}
```

---

### Layer 3: Error Boundary (MEDIUM PRIORITY)

**Add structured error handling:**

```dart
// lib/core/data/dto_mapper.dart
static Future<List<Work>> mapAndInsertSearchResponse(...) async {
  final List<Work> insertedWorks = [];
  final List<String> errors = [];

  for (final bookResult in searchResponse.results) {
    try {
      // Existing mapping logic
      final work = await _mapSingleBook(bookResult, database);
      insertedWorks.add(work);

    } on FormatException catch (e) {
      // ✅ Handle invalid data gracefully
      errors.add('Invalid format for book ${bookResult.work.title}: $e');
      debugPrint('Skipping invalid book: $e');
      continue;

    } on ApiException catch (e) {
      // ✅ Handle API errors
      errors.add('API error for book ${bookResult.work.title}: ${e.message}');
      debugPrint('Skipping book due to API error: ${e.message}');
      continue;

    } catch (e, stackTrace) {
      // ✅ Catch-all with logging
      errors.add('Unexpected error for book ${bookResult.work.title}: $e');
      debugPrint('Unexpected error: $e\n$stackTrace');
      continue;
    }
  }

  // ✅ Report partial success
  if (errors.isNotEmpty) {
    debugPrint('Completed with ${errors.length} errors:\n${errors.join('\n')}');
  }

  return insertedWorks;
}
```

---

### Layer 4: Rate Limiting (LOW PRIORITY)

**Add batch processing with limits:**

```dart
// lib/core/data/dto_mapper.dart
static Future<List<Work>> mapAndInsertSearchResponse(...) async {
  const int BATCH_SIZE = 10;
  const int MAX_TOTAL = 100;

  final results = searchResponse.results.take(MAX_TOTAL).toList();
  final List<Work> insertedWorks = [];

  // Process in batches
  for (int i = 0; i < results.length; i += BATCH_SIZE) {
    final batch = results.skip(i).take(BATCH_SIZE);

    for (final bookResult in batch) {
      // Process each book
      final work = await _mapSingleBook(bookResult, database);
      insertedWorks.add(work);
    }

    // Optional: Add delay between batches
    if (i + BATCH_SIZE < results.length) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  return insertedWorks;
}
```

---

## Priority Action Items

### 🔴 P0 (Critical - Do Now)
1. **Add ResponseValidator** - Validate all API responses before parsing
2. **Add Sanitizer** - Sanitize all user-facing strings before DB insert
3. **Add Error Boundary** - Graceful degradation for malformed data

### 🟡 P1 (High - Do This Week)
4. **Add input validation** - Length limits, format checks
5. **Add logging** - Track validation failures
6. **Add user feedback** - Show errors gracefully in UI

### 🟢 P2 (Medium - Do Later)
7. **Add rate limiting** - Batch processing, throttling
8. **Add certificate pinning** - Prevent MITM attacks
9. **Add integrity checks** - Verify critical data hasn't been tampered

---

## Testing Recommendations

### Security Tests to Add

**1. Malicious Input Tests:**
```dart
test('rejects oversized descriptions', () async {
  final malicious = WorkDTO(
    id: 'test',
    title: 'Test',
    description: 'A' * 1000000,  // 1MB string
  );

  expect(
    () => DTOMapper.mapWorkDTOToCompanion(malicious, []),
    throwsA(isA<ApiException>()),
  );
});

test('sanitizes HTML in titles', () async {
  final xss = WorkDTO(
    id: 'test',
    title: '<script>alert("xss")</script>',
  );

  final companion = DTOMapper.mapWorkDTOToCompanion(xss, []);
  expect(companion.title.value, 'alert("xss")');  // Tags stripped
});
```

**2. Fuzzing Tests:**
```dart
test('handles random malformed JSON', () async {
  for (int i = 0; i < 1000; i++) {
    final randomJson = generateRandomJson();

    expect(
      () => ResponseValidator.validateSearchResponse(randomJson),
      anyOf([
        returnsNormally,
        throwsA(isA<ApiException>()),
      ]),
    );
  }
});
```

---

## Summary

### Current Risk Score: **7/10 (High Risk)**

**Breakdown:**
- 🔴 **No input validation:** -3 points
- 🔴 **No sanitization:** -2 points
- 🟡 **Minimal error handling:** -1 point
- 🟡 **No rate limiting:** -1 point

### Target Risk Score: **2/10 (Low Risk)**

**After implementing P0 + P1:**
- ✅ Response validation
- ✅ Input sanitization
- ✅ Error boundaries
- ✅ Comprehensive logging

---

**Last Updated:** January 5, 2026
**Next Review:** After implementing P0 security layers
