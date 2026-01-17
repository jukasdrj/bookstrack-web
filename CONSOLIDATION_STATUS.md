# Flutter Repository Consolidation Status

**Date:** January 16, 2026  
**Session:** Claude.ai → handoff to Claude Code

---

## Decision: bookstrack-web is Canonical

After analyzing all three Flutter repos (books-v3/iOS, bookstrack-web, flutter), **bookstrack-web** was selected as the canonical starting point because:

1. More complete Firebase integration (v3.x packages)
2. Better organized documentation structure
3. Test infrastructure already in place
4. Web build already working
5. Clean Architecture with feature modules scaffolded

---

## Completed Fixes

### 1. Router Syntax Error (FIXED)
- **File:** `lib/app/router.dart`
- **Issue:** Extra commas (`,,,,),`) at line 63
- **Fix:** Removed extra commas

### 2. Drift Database Layer (FIXED)
- **Issue:** 1000+ compile errors in generated Drift files
- **Root Cause:** Stale generated files from older Drift version
- **Fix:** Deleted all `.g.dart` and `.freezed.dart` files, regenerated with `dart run build_runner build --delete-conflicting-outputs`
- **Result:** Database layer now compiles cleanly

### 3. FirestoreLibraryRepository (FIXED)
- **File:** `lib/core/data/repositories/firestore_library_repository.dart`
- **Issues fixed:**
  - Return type mismatch (`Stream<List<WorkWithLibraryStatus>>` → `Stream<List<Work>>`)
  - Nullable DateTime handling in sync conflict resolution
  - catchError type annotation
  - Missing required fields in `_convertToWork()` (added `authorIds`, `categories`)
  - Nullable `author` field in `_convertToFirestore()`

### 4. API Client Retry Logic (FIXED)
- **File:** `lib/core/services/api/api_client.dart`
- **Issue:** Type inference failure on `retryCount`
- **Fix:** Explicit cast `(requestOptions.extra['retryCount'] as int?) ?? 0`

### 5. BendV3 Service (FIXED)
- **File:** `lib/core/services/api/bendv3_service.dart`
- **Issue:** Dynamic type assignments in `BookResult.fromJson()`
- **Fix:** Explicit casts to `Map<String, dynamic>`

### 6. Library Screen Sort (FIXED)
- **File:** `lib/features/library/screens/library_screen.dart`
- **Issue:** Called `setSort()` but method is `setSortBy()`
- **Fix:** Changed to `setSortBy(sortBy)`

### 7. Search Screen Types (FIXED)
- **File:** `lib/features/search/screens/search_screen.dart`
- **Issues fixed:**
  - Added `AuthorDTO` import
  - Changed `List` parameters to typed `List<WorkDTO>`, `List<EditionDTO>`, `List<AuthorDTO>`
  - Fixed edition lookup with try/catch pattern
  - Removed unnecessary null-aware operator on non-nullable `authorIds`
  - Typed callback parameters `_onBookTapped(WorkDTO work)` and `_onAddToLibrary(WorkDTO work, EditionDTO? edition)`

### 8. Book Card Widgets (FIXED)
- **Files:** `lib/shared/widgets/cards/book_card.dart`, `book_grid_card.dart`
- **Issues fixed:**
  - Nullable `status` handling with early return
  - Nullable `personalRating` with null checks
  - `_getStatusColor()` null safety

### 9. Test Schema Compliance (FIXED)
- **File:** `test/core/data/models/dto_schema_compliance_test.dart`
- **Issue:** Dynamic assignment to `Map<String, dynamic>`
- **Fix:** Explicit cast on `bendv3Schemas['schemas']['Book']`

---

## Current State

### Analyze Results: 76 issues (down from 1000+)

**Errors (remaining): 4**
1. `test/core/data/models/dto_schema_compliance_test.dart:28` - dynamic assignment (partially fixed)
2. `test/integration/api_contract_test.dart:62` - dynamic to String assignment
3. `test/widget_test.dart:17` - `BooksTrackerApp` undefined
4. `test/widget_test.dart:17` - invalid constant

**Warnings: ~25** (mostly type inference and unused variables - non-blocking)

**Info: ~47** (import ordering - cosmetic only)

---

## Remaining Work

### High Priority (Blocking)

1. **Fix remaining test errors** - 4 errors in test files need type casts
2. **Run `flutter test`** - Verify tests pass after fixes

### Medium Priority (Polish)

1. **Update deprecated `withOpacity()`** - Use `.withValues(alpha: x)` instead
2. **Remove unused imports** - Clean up lint warnings
3. **Sort directive sections** - Apply `directives_ordering` fixes
4. **Add explicit type arguments** - Fix `strict_raw_type` warnings

### Low Priority (Documentation)

1. Update CLAUDE.md with consolidation notes
2. Archive or delete the duplicate `flutter` repo

---

## Commands Reference

```bash
# Regenerate code
dart run build_runner build --delete-conflicting-outputs

# Analyze
flutter analyze

# Run tests
flutter test

# Run web
flutter run -d chrome

# Run iOS (from Mac)
flutter run -d ios
```

---

## Architecture Quick Reference

- **State:** Riverpod 3.x with `@riverpod` codegen
- **Database:** Drift 2.30.1 (7 tables)
- **Navigation:** GoRouter 14.x
- **API:** Dio → `https://api.oooefam.net`
- **Firebase:** Core 3.8, Auth 5.3, Firestore 5.6

---

## Key Files

| Purpose | Location |
|---------|----------|
| Main guide | `CLAUDE.md` |
| Database schema | `lib/core/data/database/database.dart` |
| API client | `lib/core/services/api/bendv3_service.dart` |
| Router | `lib/app/router.dart` |
| iOS feature parity | `~/dev_repos/books-v3/docs/FLUTTER_FEATURE_PARITY.md` |
