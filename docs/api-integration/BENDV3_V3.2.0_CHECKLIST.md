# BendV3 v3.2.0 Integration Checklist

**Last Updated:** January 5, 2026
**BendV3 Version:** v3.2.0

Use this checklist when implementing BendV3 integration tasks.

---

## 🎯 Pre-Implementation

- [ ] Review `BENDV3_V3.2.0_REVIEW.md` (complete analysis)
- [ ] Review `BENDV3_V3.2.0_SUMMARY.md` (quick reference)
- [ ] Download OpenAPI spec locally
  ```bash
  curl https://api.oooefam.net/v3/openapi.json > docs/api-integration/openapi-v3.2.0.json
  ```
- [ ] Install npm package for type reference (optional)
  ```bash
  mkdir .tmp-bendv3-types && cd .tmp-bendv3-types
  npm install @jukasdrj/bookstrack-api-client@3.2.0
  # Reference: node_modules/@jukasdrj/bookstrack-api-client/dist/schema.ts
  ```

---

## 📦 P0 #2: Update WorkDTO

### Files to Create
- [ ] `lib/core/data/models/enums/data_provider.dart` - DataProvider enum
- [ ] `lib/core/data/models/enums/data_provider.g.dart` - Generated file
- [ ] `lib/core/data/models/enums/data_provider.freezed.dart` - Generated file

### Fields to Add (6 total)
- [ ] `subtitle` (String?)
- [ ] `description` (String?)
- [ ] `workKey` (String?) - OpenLibrary work key
- [ ] `provider` (@DataProviderConverter() DataProvider?)
- [ ] `qualityScore` (@JsonKey(name: 'quality') int?) - Range: 0-100
- [ ] `categories` (List<String>?)

### Implementation Steps
- [ ] Create DataProvider enum with JSON converter
- [ ] Update WorkDTO class
- [ ] Run code generation: `dart run build_runner build --delete-conflicting-outputs`
- [ ] Verify generated files: `work_dto.freezed.dart`, `work_dto.g.dart`
- [ ] Test JSON serialization/deserialization
- [ ] Update DTOMapper if needed

### Verification
- [ ] Enum converter handles snake_case ↔ camelCase correctly
- [ ] JSON key mapping works for `quality` → `qualityScore`
- [ ] All 6 fields serialize/deserialize correctly
- [ ] No breaking changes to existing code

---

## 📦 P0 #3: Update EditionDTO

### Fields to Add (5 total)
- [ ] `subtitle` (String?)
- [ ] `editionKey` (String?) - OpenLibrary edition key
- [ ] `thumbnailURL` (@JsonKey(name: 'thumbnailUrl') String?)
- [ ] `description` (String?)
- [ ] `categories` (List<String>?)

### Implementation Steps
- [ ] Update EditionDTO class
- [ ] Run code generation: `dart run build_runner build --delete-conflicting-outputs`
- [ ] Verify generated files: `edition_dto.freezed.dart`, `edition_dto.g.dart`
- [ ] Test JSON serialization/deserialization
- [ ] Update DTOMapper if needed

### Verification
- [ ] JSON key mapping works for `thumbnailUrl` → `thumbnailURL`
- [ ] All 5 fields serialize/deserialize correctly
- [ ] No breaking changes to existing code

---

## 📦 P0 #4: Update Database Schema to v5

### Works Table (5 new columns)
- [ ] `subtitle` (TextColumn, nullable)
- [ ] `description` (TextColumn, nullable)
- [ ] `workKey` (TextColumn, nullable)
- [ ] `provider` (TextColumn, nullable) - Store enum as string
- [ ] `qualityScore` (IntColumn, nullable)

### Editions Table (5 new columns)
- [ ] `subtitle` (TextColumn, nullable)
- [ ] `editionKey` (TextColumn, nullable)
- [ ] `thumbnailURL` (TextColumn, nullable)
- [ ] `description` (TextColumn, nullable)
- [ ] `categories` (TextColumn with ListConverter<String>, nullable)

### Migration Steps
- [ ] Update `Works` table class
- [ ] Update `Editions` table class
- [ ] Bump `schemaVersion` from 4 → 5
- [ ] Add migration logic in `MigrationStrategy.onUpgrade`
- [ ] Run code generation: `dart run build_runner build --delete-conflicting-outputs`
- [ ] Test migration with fresh database install
- [ ] Test migration from v4 → v5 (if existing data)

### Verification
- [ ] All 10 columns added successfully
- [ ] Migration runs without errors
- [ ] Existing data preserved during migration
- [ ] Query methods work with new columns

---

## 📦 P0 #1: Create BendV3Service

### Endpoints to Implement (4 total)
- [ ] `GET /v3/books/search` - Unified search
- [ ] `POST /v3/books/enrich` - Batch ISBN enrichment
- [ ] `GET /v3/books/:isbn` - Direct ISBN lookup
- [ ] `POST /v3/jobs/scans` - Bookshelf scan (bonus)

### Response Models (3 total)
- [ ] `SearchResponse` - Freezed model
- [ ] `EnrichResponse` - Freezed model
- [ ] `BookResponse` - Freezed model

### Implementation Steps
- [ ] Create `lib/core/services/api/bendv3_service.dart`
- [ ] Define response models with Freezed
- [ ] Implement 4 endpoints
- [ ] Add error handling (ApiException)
- [ ] Create Riverpod provider: `bendv3ServiceProvider`
- [ ] Run code generation
- [ ] Write unit tests

### Verification
- [ ] All endpoints return correct response types
- [ ] Error handling works (ApiException thrown)
- [ ] Provider injection works via Riverpod
- [ ] Unit tests pass

---

## 📦 P0 #5: Connect Search UI to Real API

### Files to Update
- [ ] `lib/features/search/providers/search_providers.dart`
- [ ] `lib/core/services/api/search_service.dart`

### Implementation Steps
- [ ] Update SearchNotifier to use BendV3Service
- [ ] Remove placeholder data
- [ ] Update all search modes: title, author, ISBN, advanced
- [ ] Handle API exceptions in UI (show error message)
- [ ] Test with real API calls

### Verification
- [ ] Title search works
- [ ] Author search works
- [ ] ISBN search works
- [ ] Advanced search works
- [ ] Error states display correctly
- [ ] Loading states work
- [ ] Empty states work

---

## 🆕 P2 #14: Weekly Recommendations (OPTIONAL)

### Files to Create
- [ ] `lib/features/recommendations/` directory
- [ ] `lib/features/recommendations/providers/recommendations_providers.dart`
- [ ] `lib/features/recommendations/screens/weekly_picks_screen.dart`
- [ ] `lib/features/recommendations/widgets/recommendation_card.dart`

### Implementation Steps
- [ ] Add endpoint to BendV3Service: `GET /v3/recommendations/weekly`
- [ ] Create Recommendation DTO model
- [ ] Create RecommendationsNotifier provider
- [ ] Create UI screen or section
- [ ] Display coverUrl, title, author, reason
- [ ] Add navigation from Library screen

### Verification
- [ ] Endpoint returns 10 recommendations
- [ ] UI displays reason text
- [ ] Cover images load correctly
- [ ] Updates every Sunday midnight UTC (check meta.timestamp)

---

## 🆕 P3 #16: API Capabilities Check (OPTIONAL)

### Files to Update
- [ ] `lib/app/app.dart` - Call on startup
- [ ] `lib/core/services/api/bendv3_service.dart` - Add endpoint

### Implementation Steps
- [ ] Add endpoint: `GET /v3/capabilities`
- [ ] Create Capabilities DTO model
- [ ] Call on app launch in `main.dart` or `app.dart`
- [ ] Cache in SharedPreferences
- [ ] Use to disable unsupported features
- [ ] Display API version in "About" screen

### Verification
- [ ] Capabilities fetched on startup
- [ ] Cached correctly
- [ ] Features disabled if not supported
- [ ] API version displayed in UI

---

## ✅ Final Verification

### Integration Testing
- [ ] All P0 tasks complete
- [ ] Search UI works with real API
- [ ] Database schema migrated successfully
- [ ] No runtime errors
- [ ] No analyzer warnings
- [ ] Code formatted with `dart format .`
- [ ] Pre-commit hook passes

### Performance Testing
- [ ] Image caching works (CachedNetworkImage)
- [ ] Database queries performant (batch fetching)
- [ ] API calls efficient (no N+1 queries)
- [ ] UI responsive (no jank)

### Documentation
- [ ] Update CLAUDE.md with new fields
- [ ] Update PRD if needed
- [ ] Add inline code comments for complex logic
- [ ] Update MASTER_TODO with completion status

---

## 📊 Progress Tracking

**P0 Critical Path:**
- [ ] P0 #1: Create BendV3Service
- [ ] P0 #2: Update WorkDTO
- [ ] P0 #3: Update EditionDTO
- [ ] P0 #4: Update Database Schema to v5
- [ ] P0 #5: Connect Search UI to Real API

**P2 Optional:**
- [ ] P2 #14: Weekly Recommendations

**P3 Optional:**
- [ ] P3 #16: API Capabilities Check

---

**Checklist Version:** 1.0
**Last Updated:** January 5, 2026
**BendV3 API Version:** v3.2.0
