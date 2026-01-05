# API Integration Quick Reference

**TL;DR:** Your Flutter app is missing **40+ data fields** available from Alexandria and BendV3 APIs.

---

## At a Glance

| Category | Alex | BendV3 | Flutter | Gap |
|----------|------|--------|---------|-----|
| **Book Fields** | 25 | 16 | 12 | 📊 Missing 13 fields |
| **Author Fields** | 23 | 2 | 8 | 📊 Missing 15+ diversity fields |
| **Search Modes** | 5 | 3 | 1 | 📊 Missing ISBN, author, combined |
| **Enrichment** | 7 endpoints | 2 endpoints | 0 | 📊 No enrichment implemented |
| **Cover Features** | 6 endpoints | 0 | 0 | 📊 No cover optimization |

---

## Critical Missing Fields

### WorkDTO (13 missing fields)
```dart
❌ String? subtitle              // Available in both APIs
❌ String? description           // Available in both APIs
❌ String? workKey               // OpenLibrary "/works/OL123W"
❌ String? provider              // alexandria/google_books/open_library
❌ int? qualityScore             // 0-100 from BendV3
❌ List<String>? categories      // Genres from both APIs
❌ String? thumbnailUrl          // Small cover from Alex
❌ String? coverSource           // r2/external/fallback
```

### AuthorDTO (15+ missing Wikidata fields)
```dart
❌ String? authorKey             // "/authors/OL7234434A"
❌ String? nationality           // "United States"
❌ String? genderQid             // "Q6581097" (Wikidata)
❌ String? citizenshipQid        // Country Q-ID
❌ String? birthPlace            // "New York City"
❌ String? birthCountry          // "United States"
❌ String? bio                   // Author biography
❌ String? authorPhotoUrl        // Author photo
❌ String? wikidataId            // "Q18590295"
❌ int? bookCount                // Number of books written
❌ DateTime? wikidataEnrichedAt  // Last enrichment timestamp
```

### EditionDTO (5 missing fields)
```dart
❌ String? subtitle
❌ String? editionKey            // "/books/OL7353617M"
❌ String? thumbnailUrl
❌ String? coverSource
❌ String? description
```

---

## API Capabilities Matrix

### Search & Discovery

| Feature | Alex | BendV3 | Flutter |
|---------|:----:|:------:|:-------:|
| Text search | ✅ | ✅ | ✅ |
| ISBN search | ✅ | ❌ | ❌ |
| Author search | ✅ | ❌ | ❌ |
| Combined search (auto-detect) | ✅ | ❌ | ❌ |
| Semantic search | ❌ | 🔮 Planned | ❌ |
| Similar books | ❌ | 🔮 Planned | ❌ |

### Data Enrichment

| Feature | Alex | BendV3 | Flutter |
|---------|:----:|:------:|:-------:|
| Batch ISBN enrichment | ❌ | ✅ (1-500) | ❌ |
| Async processing (>50 ISBNs) | ❌ | ✅ | ❌ |
| Author Wikidata enrichment | ✅ | ❌ | ❌ |
| Work enrichment | ✅ | ❌ | ❌ |
| Edition enrichment | ✅ | ✅ | ❌ |
| Queue-based jobs | ✅ | ✅ | ❌ |

### Cover Images

| Feature | Alex | BendV3 | Flutter |
|---------|:----:|:------:|:-------:|
| Cover URL | ✅ | ✅ | ✅ |
| Thumbnail URL | ✅ | ❌ | ❌ |
| Multi-size serving | ✅ (4 sizes) | ❌ | ❌ |
| R2 storage | ✅ | ❌ | ❌ |
| Batch upload | ✅ (1-10) | ❌ | ❌ |
| Cover status check | ✅ | ❌ | ❌ |

### Author Diversity Data

| Feature | Alex | BendV3 | Flutter |
|---------|:----:|:------:|:-------:|
| Gender | ✅ + Q-ID | ❌ | ✅ (basic) |
| Nationality | ✅ + Q-ID | ❌ | ❌ |
| Birth/Death places | ✅ + Q-IDs | ❌ | ❌ |
| Biography | ✅ | ❌ | ❌ |
| Author photo | ✅ | ❌ | ❌ |
| Wikidata ID | ✅ | ❌ | ❌ |
| Book count | ✅ | ❌ | ❌ |

---

## Integration Strategy

### Use Alexandria For:
- 🎯 **Author diversity data** (gender, nationality, birth places with Wikidata)
- 🖼️ **Cover image optimization** (R2 hosting with multiple sizes)
- 📚 **Author biographies and photos**
- 🔗 **OpenLibrary work/edition keys**
- ⚡ **Fast ISBN lookups** (Hyperdrive PostgreSQL)

### Use BendV3 For:
- 🔍 **Multi-provider search** (quality scoring across sources)
- 📦 **Batch processing** (up to 500 ISBNs at once)
- 🤖 **Async enrichment** (background jobs for large batches)
- 🔮 **Future semantic search** (when Vectorize ready)
- 📊 **Provider attribution and quality scoring**

### Hybrid Approach (Recommended):
```
User searches book
  → BendV3 /v3/search (get results with quality scores)
  → Save to local Drift database
  → Background: Alexandria /api/authors/:key (enrich author diversity data)
  → Background: Alexandria /covers/:isbn/:size (fetch optimized covers)
  → Update UI with enriched data
```

---

## Implementation Phases

### ✅ Phase 1: DTO Updates (1-2 days)
- Add 40+ missing fields to DTOs
- Update DTOMapper
- Database schema v5 migration

### ⏳ Phase 2: Search Enhancement (3-5 days)
- Implement AlexandriaService
- Add combined search endpoint
- Display quality scores

### 📅 Phase 3: Author Enrichment (5-7 days)
- Author diversity data fetching
- Wikidata integration
- Author photos display

### 🔮 Phase 4: Advanced Features (2-4 weeks)
- Cover image optimization
- Batch enrichment
- Diversity insights dashboard
- Semantic search (when ready)

---

## Quick Start Code

### Add AlexandriaService
```dart
// lib/core/services/api/alexandria_service.dart
import 'package:dio/dio.dart';

class AlexandriaService {
  final Dio _dio;
  static const baseUrl = 'https://alexandria.ooheynerds.com';

  AlexandriaService(this._dio);

  /// Auto-detect ISBN vs text search
  Future<CombinedSearchResult> searchCombined(String query) async {
    final response = await _dio.get(
      '$baseUrl/api/search/combined',
      queryParameters: {'q': query, 'limit': 20},
    );
    return CombinedSearchResult.fromJson(response.data);
  }

  /// Get full author diversity data
  Future<AuthorDetails> getAuthorDetails(String authorKey) async {
    final response = await _dio.get('$baseUrl/api/authors/$authorKey');
    return AuthorDetails.fromJson(response.data);
  }
}
```

### Provider Setup
```dart
// lib/core/providers/api_client_provider.dart
@riverpod
AlexandriaService alexandriaService(AlexandriaServiceRef ref) {
  final dio = ref.watch(apiClientProvider);
  return AlexandriaService(dio);
}
```

---

## Data Quality Examples

### Alexandria Author Record
```json
{
  "author_key": "/authors/OL7234434A",
  "name": "Toni Morrison",
  "gender": "female",
  "gender_qid": "Q6581072",
  "nationality": "United States",
  "citizenship_qid": "Q30",
  "birth_year": 1931,
  "death_year": 2019,
  "birth_place": "Lorain",
  "birth_country": "United States",
  "bio": "Toni Morrison was an American novelist...",
  "author_photo_url": "https://...",
  "wikidata_id": "Q72334",
  "book_count": 43
}
```

### BendV3 Book Record
```json
{
  "isbn": "9780439708180",
  "title": "Harry Potter and the Sorcerer's Stone",
  "authors": ["J.K. Rowling"],
  "provider": "alexandria",
  "quality": 95,
  "coverUrl": "https://...",
  "coverSource": "r2"
}
```

---

## Key Takeaways

1. **40+ fields missing** from current Flutter DTOs
2. **Alexandria** = best for author diversity & covers
3. **BendV3** = best for multi-provider search & batching
4. **Hybrid approach** gives best of both worlds
5. **Start with Phase 1** (DTO updates) this week

---

**Next Steps:**
1. Review API_DATA_COMPARISON.md for full details
2. Update DTOs with missing fields
3. Implement AlexandriaService
4. Add author diversity dashboard

**Questions?** Check the full comparison document or ask!
