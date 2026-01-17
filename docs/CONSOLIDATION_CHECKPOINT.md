# Flutter Consolidation Checkpoint - January 16, 2026

## Status: Phase 1 COMPLETE - Drift Fixed ✅

### What Was Done
1. **Selected bookstrack-web as canonical repo** (over flutter repo)
2. **Fixed router.dart syntax error** (extra commas at line 63)
3. **Regenerated Drift database files** - 1000+ errors → 0 Drift errors
4. **Identified remaining ~35 errors** to fix

### Current Error Categories

#### 1. Riverpod 3.x Migration (~10 errors)
`StateProvider` deprecated in Riverpod 3.x. Replace with `NotifierProvider`:

```dart
// OLD (broken)
final libraryFilterProvider = StateProvider<ReadingStatus?>((ref) => null);

// NEW (correct)
@riverpod
class LibraryFilter extends _$LibraryFilter {
  @override
  ReadingStatus? build() => null;
  
  void setFilter(ReadingStatus? status) => state = status;
}
```

**Files to update:**
- `lib/features/library/providers/library_providers.dart`

#### 2. Missing searchScopeNotifierProvider (4 errors)
Provider referenced but never defined:
- `lib/features/scanner/screens/scanner_screen.dart:73`
- `lib/features/search/providers/search_providers.dart:205, 216`
- `lib/features/search/screens/search_screen.dart:50`

**Fix:** Add to search_providers.dart:
```dart
@riverpod
class SearchScopeNotifier extends _$SearchScopeNotifier {
  @override
  SearchScope build() => SearchScope.all;
  
  void setScope(SearchScope scope) => state = scope;
}
```

#### 3. MobileScanner v6+ API Changes (4 errors)
- `torchState` → Use `controller.toggleTorch()` or `controller.torch` stream
- `cameraFacingState` → Use `controller.switchCamera()` or check `controller.cameraDirection`

**Files to update:**
- `lib/features/scanner/screens/scanner_screen.dart`

#### 4. Work Model Missing Required Args (2 errors)
`authorIds` and `categories` now required but not passed:
- `lib/core/data/repositories/firestore_library_repository.dart:282`

#### 5. Type Inference Warnings (~15)
Add explicit type annotations to fix inference failures.

### Database Schema (7 Tables - All Working)
1. Works, Editions, Authors, WorkAuthors
2. UserLibraryEntries, ScanSessions, DetectedItems

### Next Steps
1. Fix Riverpod StateProvider → NotifierProvider migration
2. Add missing searchScopeNotifierProvider
3. Update MobileScanner API calls
4. Add required model arguments
5. Run `flutter analyze` - target: 0 errors
6. Run `flutter run -d chrome` to verify

### Commands Reference
```bash
cd /Users/juju/dev_repos/bookstrack-web

# Regenerate code
dart run build_runner build --delete-conflicting-outputs

# Analyze
flutter analyze

# Run web
flutter run -d chrome
```

### Key Files
- **Database:** `lib/core/data/database/database.dart`
- **Router:** `lib/app/router.dart`
- **Providers:** `lib/features/*/providers/`
- **API Client:** `lib/core/services/api/api_client.dart`
