# API Data Comparison: Alex vs BendV3

**Generated:** January 4, 2026
**Purpose:** Compare available data elements from Alexandria (alex) and BooksTrack API (bendv3) to identify integration opportunities for the Flutter app.

---

## Executive Summary

### Key Findings

1. **Alexandria (alex)** provides **significantly richer metadata** including:
   - Full author diversity data (gender, nationality, birth/death places with Wikidata Q-IDs)
   - Author biographies and photos
   - Cover image processing and hosting (R2 bucket)
   - Work/Edition/Author enrichment endpoints
   - Queue-based background processing

2. **BendV3** currently provides **simplified book search** with:
   - Basic book metadata (ISBN, title, authors, publisher, pages)
   - Search modes (text, semantic planned, similar planned)
   - Provider attribution (alexandria, google_books, open_library, isbndb)
   - Quality scoring (0-100)

3. **Flutter App DTOs are missing critical fields** available from both APIs

---

## Detailed Data Element Comparison

### Book/Work/Edition Data

| Field | Alex | BendV3 | Flutter DTO | Notes |
|-------|------|--------|-------------|-------|
| **Identifiers** | | | | |
| ISBN-13 | ✅ | ✅ | ✅ | All support |
| ISBN-10 | ✅ | ✅ | ✅ | All support |
| Work Key (OpenLibrary) | ✅ | ✅ | ❌ | **MISSING in Flutter** |
| Edition Key (OpenLibrary) | ✅ | ✅ | ❌ | **MISSING in Flutter** |
| Amazon ASINs | ✅ | ❌ | ❌ | Alex-only enrichment |
| Google Books Volume IDs | ✅ | ❌ | ❌ | Alex-only enrichment |
| Goodreads Edition IDs | ✅ | ❌ | ❌ | Alex-only enrichment |
| **Metadata** | | | | |
| Title | ✅ | ✅ | ✅ | All support |
| Subtitle | ✅ | ✅ | ❌ | **MISSING in Flutter** |
| Authors (array) | ✅ | ✅ | ✅ (denormalized) | Flutter uses single author string |
| Description | ✅ | ✅ | ❌ | **MISSING in Flutter** |
| Publisher | ✅ | ✅ | ✅ | All support |
| Published Date | ✅ | ✅ | ✅ (year only) | Flutter stores only year |
| Page Count | ✅ | ✅ | ✅ | All support |
| Language | ✅ | ✅ | ✅ | All support |
| Categories/Genres | ✅ | ✅ | ✅ (subjectTags) | All support |
| Format | ✅ | ❌ | ✅ | BendV3 missing |
| **Images** | | | | |
| Cover URL | ✅ | ✅ | ✅ | All support |
| Thumbnail URL | ✅ | ❌ | ❌ | Alex-only |
| Cover Source | ✅ (r2/external/fallback) | ✅ (r2/external/fallback) | ❌ | **MISSING in Flutter** |
| Multiple Cover Sizes | ✅ (original/large/medium/small) | ❌ | ❌ | Alex R2 hosting only |
| **Quality Indicators** | | | | |
| Provider | ✅ | ✅ | ❌ | **MISSING in Flutter** |
| Quality Score | ❌ | ✅ (0-100) | ❌ | BendV3-only |
| Vectorized Flag | ❌ | ✅ (enrichment) | ❌ | BendV3 embedding support |

### Author Data

| Field | Alex | BendV3 | Flutter DTO | Notes |
|-------|------|--------|-------------|-------|
| **Basic Info** | | | | |
| Author Key | ✅ | ❌ | ❌ | Alex provides `/authors/OL123456A` |
| Name | ✅ | ✅ | ✅ | All support |
| Personal Name | ✅ | ❌ | ✅ | Alex + Flutter |
| **Diversity Data (Wikidata)** | | | | |
| Gender | ✅ | ❌ | ✅ | Alex has Q-ID too |
| Gender Q-ID | ✅ | ❌ | ❌ | **Alex-only** |
| Nationality | ✅ | ❌ | ❌ | **Alex-only** |
| Citizenship Q-ID | ✅ | ❌ | ❌ | **Alex-only** |
| Cultural Region | ❌ | ❌ | ✅ | **Flutter custom field** |
| **Biographical** | | | | |
| Birth Year | ✅ | ❌ | ✅ (full date) | Alex + Flutter |
| Death Year | ✅ | ❌ | ✅ (full date) | Alex + Flutter |
| Birth Place | ✅ | ❌ | ❌ | **Alex-only** |
| Birth Place Q-ID | ✅ | ❌ | ❌ | **Alex-only** |
| Birth Country | ✅ | ❌ | ❌ | **Alex-only** |
| Birth Country Q-ID | ✅ | ❌ | ❌ | **Alex-only** |
| Death Place | ✅ | ❌ | ❌ | **Alex-only** |
| Death Place Q-ID | ✅ | ❌ | ❌ | **Alex-only** |
| Bio | ✅ | ❌ | ❌ | **Alex-only** |
| Bio Source | ✅ | ❌ | ❌ | **Alex-only** |
| Author Photo URL | ✅ | ❌ | ❌ | **Alex-only** |
| **External IDs** | | | | |
| OpenLibrary ID | ✅ | ❌ | ✅ | Alex + Flutter |
| Wikidata ID | ✅ | ❌ | ❌ | **Alex-only** |
| Goodreads Author IDs | ✅ | ❌ | ❌ | **Alex-only** |
| Wikipedia URL | ❌ | ❌ | ✅ | **Flutter custom field** |
| **Metadata** | | | | |
| Book Count | ✅ | ❌ | ❌ | **Alex-only** |
| Wikidata Enriched At | ✅ | ❌ | ❌ | **Alex-only** |

### Search Capabilities

| Feature | Alex | BendV3 | Flutter | Notes |
|---------|------|--------|---------|-------|
| **Search Modes** | | | | |
| Text Search | ✅ | ✅ | ✅ | All support |
| ISBN Search | ✅ | ❌ | ✅ (planned) | Alex + Flutter |
| Combined Search | ✅ | ❌ | ❌ | Alex auto-detects ISBN vs text |
| Title Search | ✅ | ✅ | ✅ | All support |
| Author Search | ✅ | ❌ | ✅ (planned) | Alex + Flutter |
| Semantic Search | ❌ | ✅ (planned) | ❌ | BendV3 Vectorize integration |
| Similar Search | ❌ | ✅ (planned) | ❌ | BendV3 Vectorize integration |
| **Pagination** | | | | |
| Offset Pagination | ✅ | ✅ | ❌ | Alex + BendV3 |
| Cursor Pagination | ❌ | ✅ | ❌ | BendV3-only |
| Page/Limit | ❌ | ✅ | ❌ | BendV3 |
| Limit/Offset | ✅ | ✅ | ❌ | Alex + BendV3 |
| **Response Metadata** | | | | |
| Total Count | ✅ | ✅ | ❌ | Both APIs provide |
| Query Duration | ✅ | ❌ | ❌ | Alex-only |
| Cache Hit Flag | ✅ | ❌ | ❌ | Alex-only |
| Has More Flag | ✅ | ✅ | ❌ | Both APIs provide |

### Enrichment & Processing

| Feature | Alex | BendV3 | Flutter | Notes |
|---------|------|--------|---------|-------|
| **Enrichment Endpoints** | | | | |
| Enrich Edition | ✅ POST | ✅ POST | ❌ | Both support |
| Enrich Work | ✅ POST | ❌ | ❌ | Alex-only |
| Enrich Author | ✅ POST | ❌ | ❌ | Alex-only |
| Batch ISBN Enrichment | ❌ | ✅ (1-500 ISBNs) | ❌ | BendV3 supports batches |
| Async Processing | ❌ | ✅ (>50 ISBNs) | ❌ | BendV3 background jobs |
| Queue Enrichment Job | ✅ POST | ✅ POST | ❌ | Both support queues |
| Check Job Status | ✅ GET | ✅ GET | ❌ | Both support |
| **Cover Processing** | | | | |
| Upload/Process Cover | ✅ POST | ❌ | ❌ | Alex R2 storage |
| Batch Cover Upload | ✅ POST (1-10) | ❌ | ❌ | Alex-only |
| Cover Status Check | ✅ GET | ❌ | ❌ | Alex-only |
| Multi-Size Serving | ✅ GET /:size | ❌ | ❌ | Alex R2 (original/large/medium/small) |
| **Embedding Generation** | | | | |
| Generate Embeddings | ❌ | ✅ (optional flag) | ❌ | BendV3 for semantic search |

---

## API Endpoint Comparison

### Alexandria (alex) Endpoints

```typescript
GET  /health                     // Health check with DB latency
GET  /api/stats                  // Database statistics
GET  /api/search                 // ISBN/title/author search
GET  /api/search/combined        // Auto-detect ISBN vs text
GET  /api/authors/:key           // Full author diversity data
POST /api/enrich/edition         // Enrich edition metadata
POST /api/enrich/work            // Enrich work metadata
POST /api/enrich/author          // Enrich author with Wikidata
POST /api/enrich/queue           // Queue background enrichment
GET  /api/enrich/status          // Check enrichment job status
POST /api/covers/process         // Upload cover to R2
GET  /api/covers                 // Serve cover image
GET  /covers/:isbn/status        // Check cover availability
POST /covers/:isbn/process       // Process cover for ISBN
GET  /covers/:isbn/:size         // Serve sized cover (original/large/medium/small)
POST /covers/batch               // Batch upload 1-10 covers
```

### BendV3 Endpoints

```typescript
// From bendv3 packages/schemas:
POST /v3/search                  // Title search with pagination
POST /v3/enrich                  // Batch ISBN enrichment (1-500)
POST /v3/jobs                    // Queue background job
GET  /v3/jobs/:id                // Check job status
```

### Flutter App Currently Uses

```dart
// From lib/core/services/api/:
// SearchService endpoints (placeholders):
// - searchByTitle()
// - searchByISBN()
// - searchByBarcode()
```

---

## Integration Recommendations

### Phase 1: Essential Fields (High Priority)

**Add to Flutter DTOs immediately:**

1. **WorkDTO** (lib/core/data/models/dtos/work_dto.dart):
   ```dart
   String? subtitle,
   String? description,
   String? workKey,           // OpenLibrary work key
   String? provider,          // alexandria/google_books/open_library/isbndb
   int? qualityScore,         // 0-100
   ```

2. **EditionDTO** (lib/core/data/models/dtos/edition_dto.dart):
   ```dart
   String? subtitle,
   String? editionKey,        // OpenLibrary edition key
   String? thumbnailURL,
   String? coverSource,       // r2/external/external-fallback
   String? description,       // Book description/synopsis
   List<String>? categories,  // Genres/categories
   ```

3. **AuthorDTO** (lib/core/data/models/dtos/author_dto.dart):
   ```dart
   String? authorKey,         // "/authors/OL7234434A"
   String? genderQid,         // Wikidata Q-ID
   String? nationality,
   String? citizenshipQid,
   String? birthPlace,
   String? birthPlaceQid,
   String? birthCountry,
   String? birthCountryQid,
   String? deathPlace,
   String? deathPlaceQid,
   String? bio,
   String? bioSource,
   String? authorPhotoUrl,
   String? wikidataId,
   List<String>? goodreadsAuthorIds,
   int? bookCount,
   DateTime? wikidataEnrichedAt,
   ```

### Phase 2: Search Enhancements (Medium Priority)

**Implement Alexandria endpoints:**

1. **Combined Search** - Use `/api/search/combined?q={query}` to auto-detect ISBN vs text
2. **Author Details** - Fetch full diversity data from `/api/authors/:key`
3. **Pagination** - Add offset/limit support to all search queries

**Service Implementation:**
```dart
// lib/core/services/api/alexandria_service.dart
class AlexandriaService {
  Future<CombinedSearchResult> searchCombined(String query);
  Future<AuthorDetails> getAuthorDetails(String authorKey);
  Future<SearchResult> searchByISBN(String isbn);
  Future<SearchResult> searchByTitle(String title);
  Future<SearchResult> searchByAuthor(String author);
}
```

### Phase 3: Enrichment & Covers (Future)

**Leverage Alexandria's advanced features:**

1. **Cover Management**
   - Batch upload covers to R2
   - Serve optimized sizes (original/large/medium/small)
   - Check cover availability before fetching

2. **Metadata Enrichment**
   - Queue author Wikidata enrichment
   - Enrich work/edition metadata from multiple providers
   - Monitor enrichment job status

3. **Background Processing**
   - Use BendV3 async jobs for large batches (>50 ISBNs)
   - Queue enrichment for missing metadata
   - Generate embeddings for semantic search (when Vectorize ready)

### Phase 4: Advanced Features (Long-term)

1. **Semantic Search** - When BendV3 Vectorize integration complete
2. **Similar Books** - Recommendation engine using embeddings
3. **Author Diversity Insights** - Dashboard using Wikidata gender/nationality data
4. **Multi-Provider Quality Scoring** - Show data quality to users

---

## Database Schema Updates Required

### New Tables

```dart
// lib/core/data/database/database.dart

@DataClassName('WorkMetadata')
class WorkMetadataTable extends Table {
  TextColumn get workId => text().references(Works, #id)();
  TextColumn get provider => text()();           // alexandria/google_books
  IntColumn get qualityScore => integer()();     // 0-100
  TextColumn get workKey => text().nullable()(); // OL123456W
  DateTimeColumn get enrichedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {workId};
}

@DataClassName('CoverMetadata')
class CoverMetadataTable extends Table {
  TextColumn get isbn => text()();
  TextColumn get coverSource => text()();        // r2/external/fallback
  TextColumn get size => text()();               // original/large/medium/small
  TextColumn get url => text()();
  IntColumn get sizeBytes => integer().nullable()();
  DateTimeColumn get uploadedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {isbn, size};
}

@DataClassName('AuthorEnrichment')
class AuthorEnrichmentTable extends Table {
  TextColumn get authorId => text().references(Authors, #id)();
  TextColumn get authorKey => text().nullable()();     // /authors/OL123A
  TextColumn get genderQid => text().nullable()();
  TextColumn get nationality => text().nullable()();
  TextColumn get citizenshipQid => text().nullable()();
  TextColumn get birthPlace => text().nullable()();
  TextColumn get birthPlaceQid => text().nullable()();
  TextColumn get birthCountry => text().nullable()();
  TextColumn get birthCountryQid => text().nullable()();
  TextColumn get bio => text().nullable()();
  TextColumn get authorPhotoUrl => text().nullable()();
  TextColumn get wikidataId => text().nullable()();
  DateTimeColumn get enrichedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {authorId};
}
```

### Schema Migration

Increment `schemaVersion` to 5 and add migration logic:

```dart
// In AppDatabase._onConfigure:
@override
int get schemaVersion => 5;

@override
MigrationStrategy get migration => MigrationStrategy(
  onUpgrade: (m, from, to) async {
    if (from < 5) {
      await m.createTable(workMetadata);
      await m.createTable(coverMetadata);
      await m.createTable(authorEnrichment);
    }
  },
);
```

---

## Data Quality Considerations

### Alexandria Strengths
- ✅ **Most comprehensive author diversity data** (Wikidata integration)
- ✅ **Cover image hosting and optimization** (R2 bucket with multiple sizes)
- ✅ **Fast OpenLibrary database queries** (Hyperdrive PostgreSQL)
- ✅ **Query performance metrics** (cache hit tracking, latency)
- ✅ **Mature enrichment pipeline** (ISBNdb, Google Books, OpenLibrary, Wikidata)

### BendV3 Strengths
- ✅ **Multi-provider aggregation** (quality scoring across sources)
- ✅ **Batch processing** (up to 500 ISBNs with async support)
- ✅ **Vector search ready** (embedding generation for semantic search)
- ✅ **Modern pagination** (cursor-based for large datasets)
- ✅ **Type-safe schemas** (Zod validation with OpenAPI)

### Recommended Strategy

1. **Primary Search:** Use **BendV3** `/v3/search` for multi-provider quality scoring
2. **Author Details:** Use **Alexandria** `/api/authors/:key` for diversity data
3. **Cover Images:** Use **Alexandria** R2 hosting for optimized delivery
4. **Batch Operations:** Use **BendV3** `/v3/enrich` for large ISBN batches
5. **Real-time Enrichment:** Use **Alexandria** enrich endpoints for individual items

---

## Implementation Priority

### Immediate (This Week)
1. ✅ Add missing fields to WorkDTO/EditionDTO/AuthorDTO
2. ✅ Update DTOMapper to handle new fields
3. ✅ Increment database schema to v5
4. ✅ Add migration logic for new tables

### Short-term (Next 2 Weeks)
1. ⏳ Implement AlexandriaService for author details
2. ⏳ Add combined search endpoint
3. ⏳ Display author diversity data in UI
4. ⏳ Show data quality scores

### Medium-term (Next Month)
1. 📅 Cover image optimization using Alexandria R2
2. 📅 Background enrichment queue
3. 📅 Batch ISBN processing
4. 📅 Search pagination improvements

### Long-term (Future Phases)
1. 🔮 Semantic search integration (when Vectorize ready)
2. 🔮 Reading diversity insights dashboard
3. 🔮 Similar books recommendations
4. 🔮 Multi-provider data quality comparison

---

## NPM Package Integration

### Alexandria Worker
```bash
npm install alexandria-worker@2.2.1
```

**TypeScript Imports:**
```typescript
import type {
  SearchQuery,
  SearchResult,
  BookResult,
  AuthorDetails,
  AuthorReference,
  EnrichAuthor,
  CoverProcessResult,
} from 'alexandria-worker/types';
```

### BendV3 Schemas
```bash
npm install @bookstrack/schemas@latest
```

**TypeScript Imports:**
```typescript
import {
  BookSchema,
  SearchRequestSchema,
  SearchResponseSchema,
  EnrichRequestSchema,
} from '@bookstrack/schemas';
```

---

## Conclusion

**Alexandria (alex)** and **BendV3** are complementary APIs:

- **Alex** excels at **author diversity data** and **cover image hosting**
- **BendV3** excels at **multi-provider search** and **batch processing**

The Flutter app should leverage **both APIs** to provide the best user experience:
- Use **BendV3** for search with quality scoring
- Use **Alexandria** for author details and cover optimization
- Enrich local database with metadata from both sources

**Next Steps:**
1. Update Flutter DTOs with all available fields
2. Implement AlexandriaService for author enrichment
3. Add cover image optimization
4. Build diversity insights dashboard

---

**Document Version:** 1.0
**Last Updated:** January 4, 2026
**Maintained By:** BooksTrack Flutter Team
