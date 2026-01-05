# BendV3 Feature Requests Tracker

**Purpose:** Track feature requests and enhancements requested from BendV3 API to support Flutter app development.

**Last Updated:** January 4, 2026

---

## Active Requests

### 🎯 High Priority

#### ✅ Multi-Size Cover URL Support
**Issue:** [bendv3#237](https://github.com/jukasdrj/bendv3/issues/237)
**Status:** Filed - January 4, 2026
**Priority:** Medium (BendV3) / High Impact (Flutter)
**Estimated Effort:** 3-4 hours

**Request:**
Add `coverUrls` object with multiple image sizes to Book schema:
```typescript
coverUrls: {
  original: string,  // Full resolution
  large: string,     // ~600px
  medium: string,    // ~300px
  small: string,     // ~100px
}
coverSource: 'r2' | 'external' | 'external-fallback' | 'enriched-cached'
```

**Why We Need This:**
- **Mobile Performance:** Reduce bandwidth by serving appropriately sized images
- **Memory Optimization:** Flutter `memCacheWidth`/`memCacheHeight` require size hints
- **Progressive Loading:** Load small thumbnails first, then higher resolution
- **Data Saver:** Support low-bandwidth modes with small covers

**Flutter Impact:**
```dart
// List view - small covers
CachedNetworkImage(
  imageUrl: book.coverUrls.medium,
  memCacheWidth: 300,
  memCacheHeight: 450,
)

// Detail view - large covers
CachedNetworkImage(
  imageUrl: book.coverUrls.large,
  memCacheWidth: 600,
  memCacheHeight: 900,
)
```

**Implementation Status:**
- ✅ Alexandria already supports multi-size R2 covers
- ⏳ Waiting for BendV3 schema update
- ⏳ Need response mapping in `/v3/books/*` endpoints

**Timeline:** TBD (pending BendV3 team review)

---

## Future Requests

### 📚 Author Diversity Data

**Status:** Not yet filed
**Priority:** Medium
**Blocked By:** Alexandria Wikidata integration (in progress)

**Request:**
Expose author diversity fields from Alexandria Wikidata enrichment:
- Gender (with Wikidata Q-ID)
- Nationality/citizenship (with Q-ID)
- Birth/death places (with Q-IDs)
- Author biography
- Author photo URL
- Wikidata ID

**Why We Need This:**
- Reading diversity insights feature (planned Phase 5)
- Author detail pages with rich metadata
- Cultural representation analytics

**Current Workaround:**
- Flutter `AuthorDTO` has placeholder fields
- No data source available yet

**Timeline:** Depends on Alexandria Wikidata enrichment completion

---

### 🔍 Enhanced Search Modes

**Status:** Partially available
**Priority:** Low

**Request:**
- ✅ Text search (available)
- ⏳ Semantic search (planned - waiting for Vectorize)
- ⏳ Similar books (planned - waiting for Vectorize)
- ❓ Author search (not available)
- ❓ Advanced filters (genre, publication year, language)

**Why We Need This:**
- Better search UX
- Discovery features
- Recommendation engine

**Timeline:** Vectorize integration TBD

---

### ⚡ Performance Optimizations

**Status:** Not yet filed
**Priority:** Low

**Request:**
- Server-side pagination for search (currently client-side limited to 100 results)
- Cursor-based pagination for large result sets
- GraphQL endpoint for flexible field selection
- Batch ISBN lookup (multiple ISBNs in single GET request)

**Why We Need This:**
- Large libraries (>1000 books)
- Reduce over-fetching
- Faster response times

**Timeline:** TBD

---

## Completed Requests

### ✅ V3 API Launch
**Completed:** December 2025

**Features Delivered:**
- `/v3/books/search` - Unified search endpoint
- `/v3/books/enrich` - Batch enrichment (1-500 ISBNs)
- `/v3/books/:isbn` - Direct lookup
- `/v3/jobs/*` - Async job processing
- OpenAPI 3.1 documentation
- RFC 9457 error responses

---

## How to Request Features

1. **Discuss in Flutter team** - Validate need and use cases
2. **File GitHub issue** in bendv3 repo with:
   - Clear problem statement
   - Proposed solution (with code examples)
   - Benefits (especially for mobile/frontend)
   - Implementation estimate
3. **Add to this tracker** with status and timeline
4. **Update integration guides** when implemented

---

## BendV3 Communication Channels

- **GitHub Issues:** https://github.com/jukasdrj/bendv3/issues
- **Repository:** https://github.com/jukasdrj/bendv3
- **API Documentation:** https://api.oooefam.net/v3/docs
- **OpenAPI Spec:** https://api.oooefam.net/v3/openapi.json

---

**Maintainer:** BooksTrack Flutter Team
**Repository:** bookstrack-web
