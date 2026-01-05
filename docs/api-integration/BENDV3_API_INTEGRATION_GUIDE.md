# BendV3 API Integration Guide

**Critical Architectural Note:** Your Flutter app can ONLY communicate with **BendV3**. Alexandria is internal to BendV3 and not directly accessible.

```
Flutter App → BendV3 API → Alexandria (internal)
                         → Google Books (internal)
                         → Open Library (internal)
                         → ISBNdb (internal)
```

---

## BendV3 V3 API Endpoints (What You Can Actually Use)

### Available Endpoints

```typescript
// Book Search & Retrieval
GET  /v3/books/search      // Unified search (text/semantic/similar modes)
POST /v3/books/enrich      // Batch ISBN enrichment (1-500 ISBNs)
GET  /v3/books/:isbn       // Direct ISBN lookup

// Job Management (Async Processing)
POST /v3/jobs/imports      // CSV import job
GET  /v3/jobs/imports/:id  // Check import status
GET  /v3/jobs/imports/:id/stream  // SSE stream for progress

POST /v3/jobs/scans        // Bookshelf scan job (Gemini)
GET  /v3/jobs/scans/:id    // Check scan status
GET  /v3/jobs/scans/:id/stream    // SSE stream for progress

POST /v3/jobs/enrichment   // Background enrichment job
GET  /v3/jobs/enrichment/:id      // Check enrichment status
GET  /v3/jobs/enrichment/:id/stream  // SSE stream for progress

// Discovery
GET  /v3/capabilities      // API capabilities
GET  /v3/recommendations/weekly  // Weekly recommendations

// Webhooks (Internal Only - Alexandria callbacks)
POST /v3/webhooks/alexandria/enrichment  // Alexandria enrichment webhook

// Documentation
GET  /v3/docs              // Swagger UI
GET  /v3/openapi.json      // OpenAPI spec
```

---

## Data Available Through BendV3

### Book Schema (From BendV3 V3 API)

**All fields BendV3 exposes** (from `/src/api-v3/schemas/book.ts`):

```typescript
{
  // Identifiers
  isbn: string              // 13-digit ISBN (required)
  isbn10?: string          // 10-digit ISBN (optional)

  // Core Metadata
  title: string            // Book title (required)
  subtitle?: string        // Book subtitle
  authors: string[]        // Author names array (required)

  // Publishing Info
  publisher?: string       // Publisher name
  publishedDate?: string   // ISO 8601 or partial (e.g., "1998-09-01")
  description?: string     // Book description/synopsis
  pageCount?: number       // Number of pages
  categories?: string[]    // Genres/categories
  language?: string        // ISO 639-1 code (e.g., "en")

  // Images
  coverUrl?: string        // Cover image URL
  thumbnailUrl?: string    // Thumbnail URL

  // External IDs
  workKey?: string         // OpenLibrary work key (e.g., "OL82563W")
  editionKey?: string      // OpenLibrary edition key (e.g., "OL7353617M")

  // Quality Metadata
  provider: 'alexandria' | 'google_books' | 'open_library' | 'isbndb'
  quality: number          // 0-100 quality score
}
```

### What BendV3 DOES NOT Expose

❌ **Author diversity data** (gender, nationality, birth places, bio, photo)
❌ **Author Wikidata Q-IDs**
❌ **Multi-size cover serving** (only single coverUrl and thumbnailUrl)
❌ **Direct Alexandria endpoints** (author details, cover processing, etc.)
❌ **Cover source metadata** (r2/external/fallback) - NOT in schema despite being in code

**Key Insight:** BendV3 uses Alexandria internally but only exposes simplified book metadata.

---

## Current Flutter App Gaps

### Missing Fields in DTOs

**WorkDTO needs:**
```dart
String? subtitle,           // ✅ Available from BendV3
String? description,        // ✅ Available from BendV3
String? workKey,            // ✅ Available from BendV3
String? provider,           // ✅ Available from BendV3
int? qualityScore,          // ✅ Available from BendV3
List<String>? categories,   // ✅ Available from BendV3 (already has subjectTags)
```

**EditionDTO needs:**
```dart
String? subtitle,           // ✅ Available from BendV3
String? editionKey,         // ✅ Available from BendV3
String? thumbnailURL,       // ✅ Available from BendV3
String? description,        // ✅ Available from BendV3 (book-level)
List<String>? categories,   // ✅ Available from BendV3
```

**AuthorDTO - NO CHANGES NEEDED**
- BendV3 only returns `string[]` of author names
- No individual author metadata available
- Current Flutter AuthorDTO fields (gender, culturalRegion, etc.) must be populated from other sources

---

## Integration Strategy (Revised)

### Phase 1: DTO Updates (This Week - 1-2 days)

**Update DTOs to match BendV3 Book schema:**

```dart
// lib/core/data/models/dtos/work_dto.dart
@freezed
class WorkDTO with _$WorkDTO {
  const factory WorkDTO({
    required String id,
    required String title,

    // NEW FIELDS (from BendV3)
    String? subtitle,
    String? description,
    String? workKey,           // OpenLibrary work key
    String? provider,          // alexandria/google_books/open_library/isbndb
    int? qualityScore,         // 0-100

    // Existing fields
    String? author,
    @Default([]) List<String> authorIds,
    @Default([]) List<String> subjectTags,  // Maps to categories
    @Default(false) bool synthetic,
    String? reviewStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WorkDTO;

  factory WorkDTO.fromJson(Map<String, dynamic> json) =>
      _$WorkDTOFromJson(json);
}
```

```dart
// lib/core/data/models/dtos/edition_dto.dart
@freezed
class EditionDTO with _$EditionDTO {
  const factory EditionDTO({
    required String id,
    required String workId,

    // NEW FIELDS (from BendV3)
    String? subtitle,
    String? editionKey,        // OpenLibrary edition key
    String? thumbnailURL,
    String? description,

    // Existing fields
    String? isbn,
    String? isbn10,
    String? isbn13,
    String? publisher,
    int? publishedYear,
    String? coverImageURL,
    String? format,
    int? pageCount,
    String? language,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _EditionDTO;

  factory EditionDTO.fromJson(Map<String, dynamic> json) =>
      _$EditionDTOFromJson(json);
}
```

**Database Schema v5:**

```dart
// lib/core/data/database/database.dart

// Update Works table
class Works extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();

  // NEW COLUMNS
  TextColumn get subtitle => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get workKey => text().nullable()();
  TextColumn get provider => text().nullable()();
  IntColumn get qualityScore => integer().nullable()();

  // Existing columns...
  TextColumn get author => text().nullable()();
  TextColumn get subjectTags => text().map(const ListConverter<String>())();
  BoolColumn get synthetic => boolean().withDefault(const Constant(false))();
  TextColumn get reviewStatus => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Update Editions table
class Editions extends Table {
  TextColumn get id => text()();
  TextColumn get workId => text().references(Works, #id)();

  // NEW COLUMNS
  TextColumn get subtitle => text().nullable()();
  TextColumn get editionKey => text().nullable()();
  TextColumn get thumbnailURL => text().nullable()();
  TextColumn get description => text().nullable()();

  // Existing columns...
  TextColumn get isbn => text().nullable()();
  TextColumn get isbn10 => text().nullable()();
  TextColumn get isbn13 => text().nullable()();
  TextColumn get publisher => text().nullable()();
  IntColumn get publishedYear => integer().nullable()();
  TextColumn get coverImageURL => text().nullable()();
  TextColumn get format => text().nullable()();
  IntColumn get pageCount => integer().nullable()();
  TextColumn get language => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@override
int get schemaVersion => 5;

@override
MigrationStrategy get migration => MigrationStrategy(
  onUpgrade: (m, from, to) async {
    if (from < 5) {
      // Add new columns to Works table
      await m.addColumn(works, works.subtitle);
      await m.addColumn(works, works.description);
      await m.addColumn(works, works.workKey);
      await m.addColumn(works, works.provider);
      await m.addColumn(works, works.qualityScore);

      // Add new columns to Editions table
      await m.addColumn(editions, editions.subtitle);
      await m.addColumn(editions, editions.editionKey);
      await m.addColumn(editions, editions.thumbnailURL);
      await m.addColumn(editions, editions.description);
    }
  },
);
```

### Phase 2: Search Enhancement (Next Week - 3-5 days)

**Implement BendV3 search endpoints:**

```dart
// lib/core/services/api/bendv3_service.dart
class BendV3Service {
  final Dio _dio;
  static const baseUrl = 'https://api.oooefam.net';

  BendV3Service(this._dio);

  /// Unified search endpoint (text/semantic/similar)
  Future<SearchResponse> search({
    required String query,
    SearchMode mode = SearchMode.text,
    int page = 1,
    int limit = 20,
  }) async {
    final offset = (page - 1) * limit;
    final response = await _dio.get(
      '$baseUrl/v3/books/search',
      queryParameters: {
        'q': query,
        'mode': mode.name,
        'page': page,
        'limit': limit,
      },
    );
    return SearchResponse.fromJson(response.data);
  }

  /// Direct ISBN lookup (fastest)
  Future<Book> getBookByISBN(String isbn) async {
    final response = await _dio.get('$baseUrl/v3/books/$isbn');
    return Book.fromJson(response.data['data']);
  }

  /// Batch ISBN enrichment (1-500 ISBNs)
  Future<EnrichResponse> enrichISBNs({
    required List<String> isbns,
    bool includeEmbedding = false,
    bool async = false,
  }) async {
    final response = await _dio.post(
      '$baseUrl/v3/books/enrich',
      data: {
        'isbns': isbns,
        'includeEmbedding': includeEmbedding,
        'async': async,
      },
    );

    if (async) {
      // Returns job ID and stream URL
      return EnrichResponse.fromJson(response.data);
    } else {
      // Returns enriched books immediately
      return EnrichResponse.fromJson(response.data);
    }
  }
}
```

### Phase 3: Async Job Support (Future - 1-2 weeks)

**Background enrichment with SSE streaming:**

```dart
// lib/core/services/api/job_service.dart
class JobService {
  final Dio _dio;
  static const baseUrl = 'https://api.oooefam.net';

  JobService(this._dio);

  /// Create CSV import job
  Future<JobResponse> createImportJob(File csvFile) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(csvFile.path),
    });

    final response = await _dio.post(
      '$baseUrl/v3/jobs/imports',
      data: formData,
    );

    return JobResponse.fromJson(response.data);
  }

  /// Create bookshelf scan job (Gemini AI)
  Future<JobResponse> createScanJob(File imageFile) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imageFile.path),
    });

    final response = await _dio.post(
      '$baseUrl/v3/jobs/scans',
      data: formData,
    );

    return JobResponse.fromJson(response.data);
  }

  /// Stream job progress via SSE
  Stream<JobProgress> streamJobProgress(String jobId, String jobType) async* {
    // Use EventSource or similar SSE client
    final streamUrl = '$baseUrl/v3/jobs/$jobType/$jobId/stream';

    // Implementation depends on SSE package
    // Example: flutter_client_sse or eventsource
  }
}
```

---

## What You CANNOT Get from BendV3

### Author Diversity Data

**Not available:**
- Gender with Wikidata Q-ID
- Nationality with Q-ID
- Birth/death places with Q-IDs
- Author biography
- Author photo
- Wikidata ID
- Book count

**Workaround:**
- Keep existing `AuthorDTO` fields for potential future manual entry
- Could build admin interface to manually enrich author data
- Or consider building separate enrichment service that queries Wikidata directly

### Multi-Size Cover Images

**Not available:**
- Original/Large/Medium/Small sizes
- R2-hosted covers
- Cover processing endpoints

**Workaround:**
- Use `coverUrl` and `thumbnailUrl` from BendV3
- Implement client-side image caching with `cached_network_image`
- Use `memCacheWidth` and `memCacheHeight` for optimization

### Cover Source Metadata

**Not available in schema:**
- `coverSource` field (r2/external/fallback) exists in CODE but NOT in BookSchema

**Workaround:**
- File GitHub issue on bendv3 to add `coverSource` to BookSchema
- For now, assume all covers are external URLs

---

## Recommended Implementation Plan

### Week 1: Foundation (5-7 hours)

**Day 1-2: DTO & Database Updates**
1. ✅ Add 5 fields to WorkDTO (subtitle, description, workKey, provider, qualityScore)
2. ✅ Add 4 fields to EditionDTO (subtitle, editionKey, thumbnailURL, description)
3. ✅ Update database schema to v5
4. ✅ Add migration logic
5. ✅ Run code generation: `dart run build_runner build --delete-conflicting-outputs`
6. ✅ Test with fresh database install

**Day 3: Service Implementation**
1. ✅ Create `lib/core/services/api/bendv3_service.dart`
2. ✅ Implement `/v3/books/search` endpoint
3. ✅ Implement `/v3/books/:isbn` endpoint
4. ✅ Implement `/v3/books/enrich` endpoint (sync mode only)
5. ✅ Add Riverpod provider: `bendv3ServiceProvider`
6. ✅ Update SearchService to use BendV3Service

### Week 2: Search UI (8-10 hours)

**Day 1-2: Update Search Screen**
1. ✅ Display subtitle in search results
2. ✅ Display description in book detail view
3. ✅ Show provider badge (alexandria/google_books/etc.)
4. ✅ Display quality score (0-100) as star rating or progress indicator
5. ✅ Show categories/genres as chips

**Day 3: Update Library Screen**
1. ✅ Display enriched metadata in library
2. ✅ Show quality scores
3. ✅ Filter by provider
4. ✅ Sort by quality score

### Week 3-4: Advanced Features (Optional)

**Background Enrichment**
1. Implement async enrichment for large batches (>50 ISBNs)
2. Add SSE streaming for job progress
3. Show progress notifications

**CSV Import Integration**
1. Implement CSV file picker
2. Create import job via `/v3/jobs/imports`
3. Stream progress via SSE
4. Update library when complete

**Bookshelf Scan Integration**
1. Integrate Gemini AI scan via `/v3/jobs/scans`
2. Camera integration with preview
3. Stream detection results
4. Review queue UI

---

## Key Differences from Original Analysis

### ❌ Alexandria Direct Integration (Not Possible)

**Original recommendation:**
- ✅ Use Alexandria `/api/authors/:key` for author details
- ✅ Use Alexandria `/covers/:isbn/:size` for multi-size covers
- ✅ Implement AlexandriaService

**Reality:**
- ❌ Alexandria is internal to BendV3
- ❌ No direct access from Flutter app
- ❌ Must rely on BendV3's simplified Book schema

### ✅ BendV3-Only Integration (Actual Path)

**What you CAN do:**
- ✅ Use BendV3 `/v3/books/search` for unified search
- ✅ Use BendV3 `/v3/books/:isbn` for direct lookup
- ✅ Use BendV3 `/v3/books/enrich` for batch processing
- ✅ Use BendV3 `/v3/jobs/*` for async background jobs
- ✅ Integrate Gemini bookshelf scan via BendV3
- ✅ Import CSV via BendV3

**What you CANNOT do:**
- ❌ Access Alexandria endpoints directly
- ❌ Get author diversity data from Wikidata
- ❌ Use multi-size cover serving
- ❌ Process covers through R2

---

## Next Steps

1. **Review BendV3 OpenAPI spec:** Visit `https://api.oooefam.net/v3/docs`
2. **Update DTOs with available fields** (5 new Work fields, 4 new Edition fields)
3. **Migrate database to schema v5**
4. **Implement BendV3Service** with 3 main endpoints
5. **Update SearchService** to use BendV3Service
6. **Update UI** to display new metadata

---

## GitHub Issues Filed

### ✅ Issue #237: Multi-Size Cover URL Support
**Status:** Filed - January 4, 2026
**URL:** https://github.com/jukasdrj/bendv3/issues/237
**Priority:** Medium
**Impact:** High (improves all frontend clients)

**Request:** Add `coverUrls` object with multiple image sizes (original/large/medium/small) to Book schema for frontend optimization.

**Benefits:**
- Reduce bandwidth (serve appropriately sized images)
- Improve mobile performance (smaller images load faster)
- Better UX (progressive loading, memory optimization)
- Simpler client code (no manual resizing needed)

**Implementation:** Alexandria already supports multi-size R2 covers - just needs BendV3 schema update + response mapping.

---

## Questions for BendV3 Team (Future)

1. ✅ **Multi-size cover URLs** - Issue #237 filed
2. **Author diversity data:** Timeline for exposing Wikidata fields? (in progress on Alexandria)
3. **Semantic search:** Vectorize integration timeline?
4. **Batch enrichment limits:** How many ISBNs can we safely enrich?
5. **Rate limiting:** What are the current limits for V3 endpoints?

---

**Document Version:** 2.0 (Corrected for BendV3-only access)
**Last Updated:** January 4, 2026
**Architecture:** Flutter → BendV3 → Alexandria (internal)
