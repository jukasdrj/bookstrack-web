# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**BooksTrack Flutter** is a cross-platform book tracking application converted from iOS. The app features AI-powered bookshelf scanning using Gemini 2.0 Flash, multi-mode search, and reading analytics with diversity insights.

**Current Status:** ✅ Phase 2 Complete - Production Web App Deployed (as of Jan 17, 2026)
**Latest Achievement:** Production-ready web build deployed to Cloudflare Pages with full BendV3 API integration
**Live URL:** https://books.oooefam.net

**Key Differentiator:** Platform-agnostic Cloudflare Workers backend means zero API changes during iOS → Flutter conversion.

**Quick Links:**
- [Master TODO List](MASTER_TODO.md) - Prioritized list of all open tasks
- [Documentation Index](docs/README.md) - Organized documentation by category

## Technology Stack

### Frontend
- **Framework:** Flutter 3.38.7 (iOS + Android + Web)
- **State Management:** flutter_riverpod (^3.1.0) with code generation (@riverpod 4.0)
- **Database:** Drift (^2.30.1) - type-safe reactive SQL ORM (Web: IndexedDB, Native: SQLite)
- **Networking:** Dio (^5.7.0) with dio_cache_interceptor (^4.0.5)
- **Navigation:** go_router (^17.0.1) with StatefulShellRoute
- **Image Caching:** cached_network_image (^3.4.1)
- **Camera/Barcode:** camera (^0.11.0) + mobile_scanner (^7.1.4)
- **Firebase:** Auth (6.1.3), Firestore (6.1.1), Storage (13.0.5), Analytics (12.1.0), Crashlytics (5.0.6)

### Backend
- **Platform:** Cloudflare Workers (TypeScript) + Cloudflare Pages
- **API:** BendV3 v3.2.0 at https://api.oooefam.net
- **Datastore:** Alexandria v2.8.0 (D1 Database - 49M+ ISBNs)
- **AI:** Google Gemini 2.0 Flash (vision + text)
- **Web Deployment:** Cloudflare Pages at https://books.oooefam.net

### Design System
- **Material Design 3** with seed color #1976D2 (Blue 700)
- **Dynamic Color:** Disabled for brand consistency
- **Themes:** Light + Dark (ThemeMode.system)

## Essential Commands

### Code Generation
```bash
# Generate all code (Riverpod providers + Drift database)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for development
dart run build_runner watch --delete-conflicting-outputs
```

### Linting & Code Quality
```bash
# Run analyzer (check for issues)
flutter analyze

# Format code
dart format .

# Auto-fix many lint issues
dart fix --apply

# Test pre-commit hook
.claude/hooks/pre-commit.sh
```

**Pre-commit Hook:** Automatically runs on every `git commit`:
- ✨ Auto-formats all Dart code
- 🔐 Blocks sensitive files (.jks, .keystore, google-services.json)
- 🎯 Runs Flutter analyzer (warnings only, doesn't block)
- 🐛 Warns about `print()` statements
- ⚙️ Reminds about code generation when needed

### Running the App
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d macos
flutter run -d <device-id>

# Hot reload: Press 'r' in terminal
# Hot restart: Press 'R' in terminal
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/features/library/library_screen_test.dart

# Run with coverage
flutter test --coverage
```

### Build & Release
```bash
# iOS build
flutter build ios --release

# Android build
flutter build apk --release
flutter build appbundle --release

# macOS build (currently blocked by gRPC issue)
flutter build macos --release

# Web build (Production)
flutter build web --release

# Deploy to Cloudflare Pages (wrangler 4.59.2+)
wrangler pages deploy build/web --project-name=bookstrack-web --branch=main

# Alternative: Use wrapper script (ensures latest version)
./.cloudflare/wrangler-wrapper.sh pages deploy build/web --project-name=bookstrack-web
```

**Live Deployment:**
- **Production:** https://books.oooefam.net
- **Preview:** https://bookstrack-web.pages.dev
- **Auto-Deploy:** Enabled (GitHub main branch → Cloudflare Pages)
- **Custom Domain:** books.oooefam.net (CNAME to bookstrack-web.pages.dev)
- **Wrangler Version:** 4.59.2 (latest)

### Maintenance
```bash
# Update dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Check for issues
flutter doctor
flutter analyze

# Check for outdated packages
flutter pub outdated
```

## Claude Code Agent Setup

**Added:** November 14-15, 2025

This repository includes specialized Claude Code agents for enhanced AI collaboration.

### Available Agents

Use the `/skill` command to invoke specialized agents:

**Universal Agents (Synced from Backend):**
- `/skill project-manager` - Orchestration and task delegation
- `/skill pal-master` - Deep analysis using PAL MCP tools (debug, codereview, thinkdeep, etc.)

**Flutter-Specific Agents (TODO):**
- `/skill flutter-agent` - Flutter build, test, and deployment (planned)

### Agent Directory Structure

```
.claude/
├── README.md                    # Agent setup guide
├── ROBIT_OPTIMIZATION.md        # Complete agent architecture
├── ROBIT_SHARING_FRAMEWORK.md   # Cross-repo agent sharing
├── agents/                      # Agent configurations (JSON)
│   ├── project-orchestrator.json
│   ├── flutter-build-agent.json
│   └── pal-analysis-agent.json
├── hooks/                       # Git-like hooks
│   ├── pre-commit.sh           # Pre-commit validation
│   └── post-tool-use.sh        # Post-tool suggestions
├── prompts/                     # Reusable prompts
│   ├── plan-feature.md
│   ├── debug-issue.md
│   └── code-review.md
├── skills/                      # Skill definitions
│   ├── project-manager/
│   ├── flutter-agent/
│   └── pal-master/
└── tsc-cache/                  # TypeScript cache
```

### When to Use Agents

- **Complex Workflows:** Use `/skill project-manager` for multi-step tasks
- **Code Analysis/Review:** Use `/skill pal-master` for deep debugging
- **Flutter Operations:** Use `/skill flutter-agent` for builds/tests (when implemented)

### GitHub Infrastructure

**Labels System:** 48 labels across 7 categories
- Priority: P0-P3
- Type: bug, feature, enhancement, docs, perf, refactor, security, test
- Phase: 1-foundation through 6-launch
- Platform: android, ios, macos, web, all
- Component: database, ui, api, auth, scanner, firebase, routing, state
- Status: blocked, in-progress, needs-review, needs-testing, ready
- Effort: XS (<2h), S (2-4h), M (4-8h), L (1-2d), XL (3-5d)

See `.github/LABELS.md` for full reference.

**Workflows:**
- `.github/workflows/ci.yml` - Continuous Integration
- `.github/workflows/copilot-review.yml` - GitHub Copilot PR reviews
- `.github/workflows/deploy-cloudflare.yml` - Backend deployment

**Issue Templates:**
- `.github/ISSUE_TEMPLATE/bug.yml` - Bug reports
- `.github/ISSUE_TEMPLATE/feature.yml` - Feature requests

## Architecture Overview

### Modern Clean Architecture Structure
**Reorganized:** November 13, 2025 to industry best practices

```
lib/
├── main.dart               # App entry point (15 lines - simplified)
│
├── app/                    # App-level configuration
│   ├── app.dart           # MyApp widget
│   ├── router.dart        # GoRouter configuration
│   └── theme.dart         # Material 3 theme
│
├── core/                   # Shared infrastructure
│   ├── data/              # Data layer (Clean Architecture)
│   │   ├── database/      # Drift schema & queries
│   │   ├── models/dtos/   # API data transfer objects (Freezed)
│   │   └── repositories/  # (Future) Repository pattern
│   │
│   ├── domain/            # Domain layer (Business logic)
│   │   ├── entities/      # (Future) Domain entities
│   │   ├── usecases/      # (Future) Use cases
│   │   └── failures/      # (Future) Domain failures
│   │
│   ├── services/          # Infrastructure services
│   │   ├── api/          # API client, SearchService
│   │   ├── auth/         # Firebase Auth service
│   │   ├── sync/         # Cloud sync service
│   │   └── storage/      # (Future) Storage service
│   │
│   ├── models/           # Cross-cutting models
│   │   └── exceptions/   # ApiException, custom exceptions
│   │
│   └── providers/        # Global Riverpod providers
│
├── features/             # Feature modules
│   ├── library/          # Book collection management
│   │   ├── providers/    # Riverpod providers
│   │   ├── screens/      # UI screens
│   │   ├── widgets/      # Feature-specific widgets
│   │   └── library.dart  # Barrel export
│   │
│   ├── search/           # Multi-mode search
│   │   └── screens/      # (Placeholder)
│   │
│   ├── scanner/          # Barcode scanner
│   │   └── screens/      # (Placeholder)
│   │
│   ├── bookshelf_scanner/ # AI bookshelf scanner (planned)
│   ├── review_queue/     # Review queue for AI detections (planned)
│   └── insights/         # Reading analytics
│       └── screens/      # (Placeholder)
│
└── shared/               # Reusable components
    └── widgets/
        ├── cards/        # BookCard, BookGridCard
        ├── layouts/      # MainScaffold, etc.
        ├── buttons/      # (Future)
        ├── loading/      # (Future)
        └── dialogs/      # (Future)
```

**Key Changes (Nov 13, 2025):**
- ✅ Extracted app configuration to `lib/app/` directory
- ✅ Reorganized core into `data/` and `services/` layers
- ✅ Organized services by type: `api/`, `auth/`, `sync/`, `storage/`
- ✅ Added placeholder `domain/` directories for future Clean Architecture migration
- ✅ Barrel exports added for each feature (e.g., `library.dart`)
- ✅ Shared widgets reorganized
- ✅ main.dart simplified from ~150 lines to 15 lines

**Benefits:**
- Scalability - Add features without touching existing code
- Testability - Clear boundaries make testing easy
- Maintainability - Everything has a proper home
- Team Collaboration - Reduced merge conflicts
- Industry Standard - Follows 2025 best practices

### Critical Patterns

#### 1. Database Layer (Drift)
- **Schema Version:** 4 (see `lib/core/data/database/database.dart:260`)
- **Tables:** Works, Editions, Authors, WorkAuthors (junction), UserLibraryEntries, ScanSessions, DetectedItems
- **Key Principle:** All queries return reactive `Stream<T>` via `.watch()`
- **N+1 Prevention:** Use `_getBatchAuthorsForWorks()` for author fetching
- **Pagination:** Keyset-based with composite cursor `"timestamp|id"`
- **Location:** `lib/core/data/database/`

**Example:**
```dart
Stream<List<WorkWithLibraryStatus>> watchLibrary({
  ReadingStatus? filterStatus,
  String? cursor,  // "2024-01-15T10:30:00.000Z|abc123"
  int limit = 50,
}) {
  // Filters on (updatedAt, id) composite key
  // Orders by both fields (tie-breaker)
  // Uses idx_library_updated_id index
}
```

#### 2. State Management (Riverpod)
- **Code Generation:** All providers use `@riverpod` annotation
- **Pattern:** `ConsumerWidget` or `ConsumerStatefulWidget` for UI
- **Watching:** `ref.watch()` for rebuilds, `ref.read()` for one-time access
- **Providers:**
  - `databaseProvider` - Global AppDatabase instance
  - `watchLibraryWorksProvider` - Reactive library stream
  - `libraryFilterProvider` - Filter state (ReadingStatus?)
  - `librarySortOptionProvider` - Sort state (SortBy enum)
  - `bookActionsProvider` - CRUD operations

**Example:**
```dart
@riverpod
class LibraryFilter extends _$LibraryFilter {
  @override
  ReadingStatus? build() => null;

  void setFilter(ReadingStatus? status) => state = status;
}
```

#### 3. API Client & Services
- **Base URL:** `https://api.oooefam.net` (Cloudflare Workers backend)
- **HTTP Client:** Dio with caching interceptor
- **Timeout:** 60s receive timeout (supports AI processing)
- **Location:** `lib/core/services/api/`
- **Pattern:** UI → Provider → Service → Dio → API endpoint

**Key Services:**
- `ApiClient` - Base HTTP client configuration
- `SearchService` - Search endpoints (/v1/search/*, /v1/search/isbn/*, /v1/search/barcode/*)
- `AuthService` - Firebase authentication
- `SyncService` - Cloud sync operations

**Error Handling:**
```dart
// lib/core/models/exceptions/api_exception.dart
class ApiException implements Exception {
  /// Canonical error code from API (INVALID_QUERY, INVALID_ISBN, etc)
  final String code;

  /// User-friendly error message from API
  final String message;

  /// Additional error details (optional)
  final Map<String, dynamic>? details;

  ApiException({
    required this.code,
    required this.message,
    this.details,
  });
}
```

**Provider Pattern:**
```dart
// lib/core/providers/api_client_provider.dart
@riverpod
Dio apiClient(ApiClientRef ref) {
  return ApiClient.create();
}

@riverpod
SearchService searchService(SearchServiceRef ref) {
  final dio = ref.watch(apiClientProvider);
  return SearchService(dio);
}

// Usage in a widget/provider
final searchService = ref.watch(searchServiceProvider);
final results = await searchService.searchByTitle(query);
```

#### 4. Navigation (GoRouter)
- **Configuration:** `lib/app/router.dart`
- **Pattern:** `StatefulShellRoute.indexedStack` for persistent tab state
- **Routes:** 4 main tabs (Library, Search, Scanner, Insights)
- **Deep Linking:** Supported via path parameters

**Example:**
```dart
StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
    return MainScaffold(navigationShell: navigationShell);
  },
  branches: [
    StatefulShellBranch(routes: [GoRoute(path: '/library', ...)]),
    // ... 3 more branches
  ],
)
```

#### 5. DTOMapper Pattern
- **Purpose:** Convert API DTOs to Drift database models
- **Critical:** Use `dto.id` from API (NOT UUID generation) and `workDTO.authorIds` for relationships
- **Transactions:** Wrap inserts in `database.transaction()` for atomicity
- **Location:** `lib/core/data/dto_mapper.dart`
- **Status:** 100% compliant with canonical TypeScript contracts (as of Nov 13, 2025)

**Anti-Pattern (DO NOT USE):**
```dart
// ❌ WRONG: Assumes authors in same order as works
final editionDTO = i < data.editions.length ? data.editions[i] : null;
```

**Correct Pattern:**
```dart
// ✅ CORRECT: Use authorIds for relationship mapping
final authorDTOs = data.authors
    .where((a) => workDTO.authorIds.contains(a.id))
    .toList();
```

## Performance Critical Code

### 1. Image Loading
**Always use CachedNetworkImage with memory optimization:**
```dart
CachedNetworkImage(
  imageUrl: coverUrl,
  fit: BoxFit.cover,
  memCacheWidth: 240,  // 80 * 3 for Retina displays
  memCacheHeight: 360, // 120 * 3
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.book),
)
```

### 2. Database Queries
**Batch Fetching Pattern:**
```dart
// ✅ GOOD: Single query for all authors
Future<Map<String, List<Author>>> _getBatchAuthorsForWorks(List<String> workIds) async {
  final query = select(authors).join([...])
    ..where(workAuthors.workId.isIn(workIds));
  // ... group by workId
}

// ❌ BAD: N+1 query anti-pattern
for (final work in works) {
  final authors = await _getAuthorsForWork(work.id);  // N queries!
}
```

### 3. Keyset Pagination
**Composite Cursor Pattern:**
```dart
// Cursor format: "timestamp_iso8601|id"
if (cursor != null && cursor.contains('|')) {
  final parts = cursor.split('|');
  final lastTimestamp = DateTime.parse(parts[0]);
  final lastId = parts[1];

  query.where(
    updatedAt.isSmallerThanValue(lastTimestamp) |
    (updatedAt.equals(lastTimestamp) & id.isSmallerThan(lastId)),
  );
}
```

## Data Models

### Core Entities

**Works** - Book metadata
- Primary key: `id` (UUID)
- Fields: `title`, `author` (denormalized), `subjectTags`, `synthetic`, `reviewStatus`
- Relationships: Many-to-many with Authors via WorkAuthors

**Editions** - Physical/digital book editions
- Foreign key: `workId` → Works
- Fields: `isbn`, `publisher`, `publishedYear`, `coverImageURL`, `format`, `pageCount`

**Authors** - Author information
- Fields: `name`, `gender`, `culturalRegion`, external IDs
- Relationships: Many-to-many with Works

**UserLibraryEntries** - User's reading list
- Foreign keys: `workId` → Works, `editionId` → Editions
- Fields: `status` (wishlist/toRead/reading/read), `currentPage`, `personalRating`, `notes`
- **Indexes:** `(updatedAt, id)`, `(status, updatedAt)` for pagination

**ScanSessions** - AI scan metadata
- Fields: `totalDetected`, `reviewedCount`, `acceptedCount`, `rejectedCount`, `status`
- Cascade delete: Removes all DetectedItems when session deleted

**DetectedItems** - Individual AI detections
- Foreign keys: `sessionId` → ScanSessions, `workId` → Works (nullable)
- Fields: `titleGuess`, `authorGuess`, `confidence`, `imagePath`, `boundingBox`, `reviewStatus`
- **Indexes:** `(sessionId, reviewStatus)`, `confidence`

### DTO Contracts

All API responses follow the pattern:
```dart
@freezed
class ResponseEnvelope<T> with _$ResponseEnvelope<T> {
  const factory ResponseEnvelope({
    required bool success,
    T? data,
    ErrorDetails? error,
    required MetaData meta,
  }) = _ResponseEnvelope<T>;
}
```

## Code Quality & Linting

### Linting Configuration

**Setup:** Production-ready linting optimized for Claude Code CLI workflow (no VS Code required)

**Location:** `analysis_options.yaml`

**Active Rules:** 16 carefully selected lint rules organized by category:

#### Code Style (7 rules)
- `prefer_const_constructors` - Memory optimization
- `prefer_const_literals_to_create_immutables` - Performance
- `prefer_final_fields` - Immutability
- `prefer_single_quotes` - Dart convention
- `require_trailing_commas` - Better Git diffs
- `always_declare_return_types` - Type safety
- `directives_ordering` - Clean imports

#### Error Prevention (5 rules)
- `avoid_print` - Use `debugPrint()` instead
- `cancel_subscriptions` - Prevent memory leaks
- `close_sinks` - Prevent resource leaks
- `unawaited_futures` - Catch async bugs
- `use_build_context_synchronously` - Prevent build context errors

#### Code Quality (4 rules)
- `prefer_is_empty` / `prefer_is_not_empty` - Readability
- `use_key_in_widget_constructors` - Widget optimization
- `sized_box_for_whitespace` - Performance
- `avoid_unnecessary_containers` - Cleaner widget tree
- `unnecessary_null_checks` - Cleaner null safety

**Strict Type Checking Enabled:**
- `strict-casts: true` - Catch unsafe casts
- `strict-inference: true` - Better type inference
- `strict-raw-types: true` - Prevent untyped generics

### Automated Pre-Commit Hook

**Location:** `.git/hooks/pre-commit` → `.claude/hooks/pre-commit.sh`

**Runs automatically on every `git commit`:**
1. 🔐 **Security Check** - Blocks sensitive files (.jks, .keystore, google-services.json, etc.)
2. ⚙️ **Code Generation** - Warns if provider/database files changed
3. ✨ **Auto-Format** - Runs `dart format .` automatically
4. 🎯 **Analyzer** - Runs `flutter analyze` (warnings only, doesn't block)
5. 🐛 **Debug Check** - Warns about `print()` statements
6. 📦 **Dependency Check** - Validates pubspec.yaml

**Test manually:**
```bash
.claude/hooks/pre-commit.sh
```

**Skip hook (not recommended):**
```bash
git commit --no-verify -m "Your message"
```

### Documentation

**Complete Guide:** `LINTING_SETUP.md` (400+ lines)
- Full setup documentation
- Usage examples
- Troubleshooting
- Customization guide

## Known Issues & Workarounds

### macOS Build Failure
**Issue:** gRPC incompatibility with macOS 26.1 Sequoia
```
clang: error: unsupported option '-G' for target 'arm64-apple-macos10.12'
```
**Workaround:** Test on iOS/Android/Web instead. Tracked in Firebase issue.

### iOS Device Testing
**Issue:** Requires iOS 26.1 SDK installation in Xcode
**Fix:** Xcode > Settings > Components > Download iOS 26.1

## Material Design 3 Guidelines

### Component Usage
- **Navigation:** `NavigationBar` (not BottomNavigationBar)
- **Buttons:** `FilledButton`, `OutlinedButton`, `TextButton`
- **Filters:** `FilterChip` with `selectedColor: colorScheme.primaryContainer`
- **Cards:** 12dp corner radius, `clipBehavior: Clip.antiAlias`
- **Icons:** Outlined when inactive, filled when active

### Theme Configuration
```dart
// lib/app/theme.dart
static final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF1976D2),  // Blue 700
    brightness: Brightness.light,
  ),
);
```

## Testing Strategy

### Unit Tests
- Database queries (Drift)
- DTOMapper transformations
- Provider logic (Riverpod)

### Widget Tests
- Screen rendering
- User interactions
- State changes

### Integration Tests
- Full user flows
- Database + UI integration
- Navigation flows

## Documentation

**Primary References:**
- **[MASTER_TODO.md](MASTER_TODO.md)** - Prioritized list of all open tasks (P0-P3)
- **[docs/README.md](docs/README.md)** - Complete documentation index

All documentation has been organized into the `docs/` directory by category:

**Key Documentation Directories:**
- `docs/api-integration/` - BendV3 API integration guides and audits
- `docs/planning/` - Roadmaps, progress tracking, and session summaries
- `docs/agent-optimization/` - Claude Code agent optimization
- `docs/setup/` - Installation, linting, and deployment guides
- `docs/firebase/` - Firebase integration and migration
- `docs/reference/` - Legacy and reference materials

**Architecture & Setup:**
- `CLAUDE.md` - This file (AI assistant guide)
- `.claude/README.md` - Claude Code agent setup
- `.claude/ROBIT_OPTIMIZATION.md` - Agent architecture
- `.claude/ROBIT_SHARING_FRAMEWORK.md` - Cross-repo agent sharing
- `docs/setup/LINTING_SETUP.md` - Complete linting and code quality guide

**Code Quality:**
- `analysis_options.yaml` - 16 production-ready lint rules
- `.claude/hooks/pre-commit.sh` - Automated pre-commit checks
- `.git/hooks/pre-commit` - Git hook (calls Claude hook)

**GitHub Infrastructure:**
- `.github/LABELS.md` - Label system reference (48 labels)
- `.github/BENDV3_FEATURE_REQUESTS.md` - BendV3 API feature request tracker
- `.github/REORGANIZATION_COMPLETE.md` - Nov 13 reorganization summary
- `.github/FLUTTER_ORGANIZATION_PLAN.md` - Architecture plan
- `.github/AI_COLLABORATION.md` - AI collaboration guide

**Product Requirements:**
- `product/*.md` - Product requirement documents (PRDs)
- `product/*-PRD-Flutter.md` - Converted Flutter PRDs
- `product/*-PRD.md` - Original iOS PRDs
- `product/PRD-Template.md` - Template for new PRDs
- `product/CONVERSION_SUMMARY.md` - iOS → Flutter conversion guide
- `product/QUICK_REFERENCE.md` - Quick product reference

## iOS → Flutter Architecture Mapping

| iOS Pattern | Flutter Equivalent | Package |
|-------------|-------------------|---------|
| SwiftUI Views | StatelessWidget / ConsumerWidget | flutter |
| @Observable | StateNotifier with @riverpod | riverpod |
| @State / @Binding | Provider / StateProvider | riverpod |
| SwiftData @Model | Drift Table | drift |
| AVFoundation | CameraController | camera |
| VisionKit barcode | MobileScanner | mobile_scanner |
| URLSession | Dio | dio |
| NavigationStack | GoRouter + StatefulShellRoute | go_router |
| UserDefaults | SharedPreferences | shared_preferences |
| @globalActor | Isolate.run() | dart:isolate |

## Platform-Specific Considerations

### Web Support
- Use `kIsWeb` for conditional logic
- Scanner: File upload fallback (no camera access)
- Database: Drift with `sqlite3_web` (WASM)
- Navigation: URL-based routing works automatically

### iOS
- App Tracking Transparency (ATT) required for analytics
- Universal Links: Configure in Info.plist
- Push Notifications: APNs certificates

### Android
- Deep Links: Configure in AndroidManifest.xml
- Permissions: Camera, storage in AndroidManifest.xml
- Notification channels required for Android 8+

## Recent Accomplishments

### Phase 1 Completion (November 13, 2025)
**Status:** 100% Complete ✅

**Key Achievements:**
1. ✅ **Project Reorganization** - Modernized to Clean Architecture (26 files reorganized)
2. ✅ **DTO Compliance** - Achieved 100% compliance with canonical TypeScript contracts
3. ✅ **API Client Implementation** - SearchService with 3 endpoints fully functional
4. ✅ **Infrastructure Setup** - Riverpod providers, ApiException, service layer complete
5. ✅ **Code Review** - Expert validated (8.6/10 quality score)
6. ✅ **Documentation** - 1500+ lines of comprehensive documentation
7. ✅ **GitHub Infrastructure** - 48 labels, workflows, issue templates

### Agent Setup (November 14-15, 2025)
**Status:** Complete ✅

1. ✅ Created `.claude/` directory structure
2. ✅ Synced universal agents from backend (project-manager, pal-master)
3. ✅ Added hooks (pre-commit, post-tool-use)
4. ✅ Created reusable prompts (plan-feature, debug-issue, code-review)
5. ✅ Configured MCP server integration

### Phase 2: Search Feature Implementation (December 26, 2025)
**Status:** 100% Complete ✅

**Core Search Features:**
1. ✅ **Multi-Mode Search** - Title, Author, ISBN, and Advanced search capabilities
2. ✅ **Material 3 Design** - SearchBar widget, FilterChips, modern UI components
3. ✅ **State Management** - Complete Riverpod integration with reactive providers
4. ✅ **Error Handling** - Comprehensive API exception handling and user feedback
5. ✅ **Responsive UI** - Loading, empty, and error states with retry functionality

### Production Web Deployment (January 17, 2026)
**Status:** ✅ LIVE IN PRODUCTION

**Major Updates:**
1. ✅ **Package Updates** - All 13 major packages updated (Riverpod 4.0, Firebase 6.x, go_router 17.0)
2. ✅ **Web Platform Support** - Fixed Drift database for web (IndexedDB instead of FFI)
3. ✅ **BendV3 API Integration** - Fully connected to production API (https://api.oooefam.net)
4. ✅ **Cloudflare Pages Deployment** - Live at https://books.oooefam.net
5. ✅ **BookDTO Parsing** - Handles enriched author data from Alexandria
6. ✅ **Production Build** - Optimized 2.9 MB bundle (99.3% icon tree-shaking)

**Live Features:**
- Real-time book search (49M+ ISBNs via Alexandria)
- ISBN lookup with validation
- Cover image loading from Alexandria CDN
- Error handling and retry logic
- Mobile-responsive Material Design 3 UI

**Deployment:**
- **Custom Domain:** books.oooefam.net
- **Auto-Deploy:** GitHub main branch → Cloudflare Pages
- **Preview Deployments:** Every commit gets unique URL
- **Integration:** Same Cloudflare account as BendV3 API worker

**Technical Implementation:**
- **Search State Model** - Freezed models with 5 distinct states (initial, loading, results, empty, error)
- **Provider Architecture** - SearchScopeNotifier, SearchQuery, and main Search provider
- **Auto-Search** - Debounced search with 300ms delay for optimal UX
- **ISBN Validation** - Input cleaning and format validation
- **Barcode Integration** - FloatingActionButton for future scanner integration

**Infrastructure Created:**
- Complete DTO models (WorkDTO, EditionDTO, AuthorDTO) with code generation
- SearchService with placeholder API integration
- MainScaffold navigation and shared widgets
- Exception handling with ApiException for structured error management

### Claude Code Agent Optimization Analysis (December 26, 2025)
**Status:** Analysis Complete ✅

**Current Agent Setup Assessment:**
- **Status:** 85% optimized with excellent 3-agent architecture
- **Configuration:** 4,000+ lines of comprehensive agent setup
- **Architecture:** Production-ready project-orchestrator → flutter-agent + pal-master

**Critical Optimization Opportunities Identified:**
1. **Agent Memory & Learning System** (Missing - High Impact)
2. **Cross-Repo Synchronization** (Framework documented but not automated)
3. **Safety Guardrails & Autonomy Controls** (Basic implementation)
4. **Proactive Agent Routing** (Currently reactive only)
5. **Structured Output Standardization** (Narrative responses only)

**Optimization ROI Potential:**
- **Phase 1 Foundation:** $3,200 annual savings (533% ROI)
- **Phase 2 Intelligence:** $3,500 annual savings (380% ROI)
- **Phase 3 Scale:** $2,000 annual savings (200% ROI)
- **Total Potential:** $8,700+ savings for 35-47 hours investment

**Documentation Created:**
- `CLAUDE_OPTIMIZATION_ANALYSIS.md` - Complete assessment with gap analysis
- `OPTIMIZATION_RECOMMENDATIONS.md` - Step-by-step implementation guide
- `PHASE_IMPLEMENTATION_PLAN.md` - 6-week roadmap with code examples

## Development Workflow

### Daily Workflow (Claude Code CLI)

**Normal Development:**
```bash
# 1. Make code changes
# 2. Commit when ready
git add .
git commit -m "Your message"

# Pre-commit hook automatically:
# - Formats code
# - Runs analyzer
# - Checks for issues
# - Allows commit (warnings don't block)

# 3. Push to remote
git push
```

**After Modifying Providers/Database:**
```bash
# Run code generation
dart run build_runner build --delete-conflicting-outputs

# Or use watch mode during active development
dart run build_runner watch --delete-conflicting-outputs
```

**Periodic Code Quality Checks:**
```bash
# Run analyzer
flutter analyze

# Auto-fix lint issues
dart fix --apply

# Format code manually (if needed)
dart format .
```

### Using Barrel Exports (New Pattern)

**Before Reorganization:**
```dart
import 'package:books_tracker/features/library/screens/library_screen.dart';
import 'package:books_tracker/features/library/widgets/book_card.dart';
import 'package:books_tracker/features/library/providers/library_providers.dart';
```

**After Reorganization:**
```dart
import 'package:books_tracker/features/library/library.dart';
```

### Adding New Features (Updated)
1. Create feature directory: `lib/features/<feature>/`
2. Add subdirectories: `providers/`, `screens/`, `widgets/`
3. Create barrel export: `lib/features/<feature>/<feature>.dart`
4. Define Riverpod providers with `@riverpod` annotation in `providers/`
5. Create Drift queries if needed in `lib/core/data/database/`
6. Run code generation: `dart run build_runner build`
7. Implement UI with `ConsumerWidget` in `screens/`
8. Add route to `lib/app/router.dart`

### Database Schema Changes (Updated)
1. Update table classes in `lib/core/data/database/database.dart`
2. Increment `schemaVersion` (currently 4)
3. Add migration logic if needed
4. Run: `dart run build_runner build --delete-conflicting-outputs`
5. Test with fresh database install

### Adding API Integration (Updated)
1. Define DTOs in `lib/core/data/models/dtos/` using Freezed
2. Update `DTOMapper` in `lib/core/data/dto_mapper.dart`
3. Add service class in `lib/core/services/api/` (e.g., SearchService)
4. Create provider in `lib/core/providers/`
5. Consume in feature's `domain/providers/`
6. Run code generation

### API Integration Analysis (January 4, 2026)
**Status:** Complete ✅ (Corrected for BendV3-only access)

**Critical Architecture Constraint:**
- Flutter app can **ONLY** communicate with **BendV3**
- Alexandria is **internal** to BendV3 (not directly accessible)
- Architecture: `Flutter → BendV3 → Alexandria (internal)`

**BendV3 V3 API Endpoints Available:**
```
GET  /v3/books/search      - Unified search (text/semantic/similar)
POST /v3/books/enrich      - Batch ISBN enrichment (1-500)
GET  /v3/books/:isbn       - Direct ISBN lookup
POST /v3/jobs/imports      - CSV import (async job)
POST /v3/jobs/scans        - Bookshelf scan (Gemini AI)
POST /v3/jobs/enrichment   - Background enrichment
GET  /v3/capabilities      - API capabilities
```

**Available BendV3 Book Fields:**
- ✅ **9 NEW fields** can be added: subtitle, description, workKey, editionKey, provider, quality (0-100), thumbnailUrl, categories
- ❌ **Author diversity data NOT available** (gender, nationality, bio, photo) - BendV3 only returns `string[]` of names
- ❌ **Multi-size covers NOT available** - Only single coverUrl + thumbnailUrl
- ❌ **Alexandria endpoints NOT accessible** - All Alexandria data proxied through BendV3

**Recommended Next Steps:**
1. **Phase 1:** Add 9 available fields to DTOs (subtitle, description, etc.) - 1-2 days
2. **Phase 2:** Implement BendV3Service with 3 main endpoints - 3-5 days
3. **Phase 3:** Async job support (CSV import, bookshelf scan) - 1-2 weeks
4. **Phase 4:** Semantic search when Vectorize ready - future

**Documentation Created:**
- ⭐ `BENDV3_API_INTEGRATION_GUIDE.md` - **CORRECTED** integration guide (BendV3-only)
- `API_DATA_COMPARISON.md` - Reference comparison (Alexandria internal only)
- `API_INTEGRATION_QUICK_REFERENCE.md` - Reference (Alexandria internal only)

---

**Last Updated:** January 5, 2026
**Project Status:** Phase 2 Search Feature - 100% UI Complete, API Integration Pending
**Latest Achievement:** Master TODO list created (15 prioritized tasks) + documentation reorganized into `docs/`
**Code Quality:** Production-ready with 16 lint rules + automated formatting
**Development Workflow:** Claude Code CLI optimized (no VS Code required)
**Dependencies:** All 25 packages installed and code generation working (102 files generated)
