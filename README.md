# BooksTrack - AI-Powered Book Tracking 📚

> Cross-platform book tracking with Gemini AI bookshelf scanning and diversity insights

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-blue)](https://dart.dev)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

**BooksTrack** is a modern, cross-platform book tracking application built with Flutter. It features AI-powered bookshelf scanning using Google Gemini 2.0 Flash, multi-mode search, reading analytics, and diversity insights - all with a beautiful Material Design 3 interface.

**Key Differentiator:** Platform-agnostic Cloudflare Workers backend means zero API changes during iOS → Flutter conversion.

---

## ✨ Key Features

### 📸 AI Bookshelf Scanner
- Photograph your bookshelf with your camera
- Google Gemini 2.0 Flash AI detects and identifies books
- Review queue for accepting/rejecting detections
- Batch add detected books to your library

### 🔍 Multi-Mode Search
- **Title Search** - Find books by title
- **Author Search** - Search by author name
- **ISBN Search** - Lookup books by ISBN-10 or ISBN-13
- **Barcode Scanner** - Scan physical book barcodes (mobile only)
- **Advanced Search** - Combine multiple criteria

### 📚 Library Management
- Track reading status (Wishlist, To Read, Reading, Read)
- Record reading progress and personal ratings
- Add private notes to books
- Filter and sort your collection
- Beautiful card-based UI with cover images

### 📊 Reading Analytics (Coming Soon)
- Reading statistics and trends
- Author diversity insights (gender, cultural regions)
- Language diversity tracking
- Reading goal progress

### ☁️ Cloud Sync
- Firebase Firestore synchronization
- Local-first architecture with Drift database
- Works offline with automatic sync when online
- Cross-device library access

---

## 🚀 Quick Start

### Prerequisites

- **Flutter SDK** 3.x or higher ([install guide](https://flutter.dev/docs/get-started/install))
- **Dart SDK** 3.x or higher (included with Flutter)
- **Git** for version control

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/bookstrack-web.git
   cd bookstrack-web
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
   This generates Riverpod providers and Drift database code.

4. **Run the app**
   ```bash
   # Web (Chrome)
   flutter run -d chrome

   # macOS Desktop
   flutter run -d macos

   # iOS Simulator
   flutter run -d "iPhone 15 Pro"

   # Android Emulator
   flutter run -d emulator-5554
   ```

5. **Build for production**
   ```bash
   # Web
   flutter build web --release

   # iOS
   flutter build ios --release

   # Android
   flutter build apk --release
   flutter build appbundle --release
   ```

---

## 🏗️ Architecture

BooksTrack follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── app/                   # App configuration (theme, routing)
├── core/                  # Shared infrastructure
│   ├── data/             # Data layer (DTOs, database, repositories)
│   ├── services/         # API client, auth, sync services
│   └── providers/        # Global Riverpod providers
├── features/             # Feature modules
│   ├── library/          # Book collection management
│   ├── search/           # Multi-mode search
│   ├── scanner/          # Barcode scanner
│   ├── bookshelf_scanner/ # AI bookshelf scanner
│   └── insights/         # Reading analytics
└── shared/               # Reusable widgets
```

**Key Technologies:**
- **State Management:** flutter_riverpod with code generation
- **Database:** Drift (type-safe SQL ORM) + Firebase Firestore
- **Routing:** go_router with StatefulShellRoute
- **HTTP:** Dio with caching interceptor
- **UI:** Material Design 3 with dynamic theming

For detailed architecture documentation, see [CLAUDE.md](CLAUDE.md).

---

## 🔌 Backend API

BooksTrack communicates with the BendV3 backend API:

- **Base URL:** `https://api.oooefam.net`
- **API Version:** v3.2.0
- **Documentation:** [BendV3 Integration Guide](docs/api-integration/BENDV3_API_INTEGRATION_GUIDE.md)

**Main Endpoints:**
- `GET /v3/books/search` - Unified book search
- `GET /v3/books/:isbn` - ISBN lookup
- `POST /v3/books/enrich` - Batch ISBN enrichment (1-500)
- `POST /v3/jobs/scans` - AI bookshelf scan
- `GET /v3/recommendations/weekly` - Weekly book recommendations

---

## 📱 Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| **iOS** | ✅ Ready | iPhone 15+ with iOS 17+ |
| **Android** | ✅ Ready | Android 8.0+ (API level 26+) |
| **Web** | ✅ Ready | Chrome, Safari, Firefox, Edge |
| **macOS** | ⚠️ Blocked | [gRPC compatibility issue](https://github.com/firebase/flutterfire/issues) |
| **Linux** | 🚧 Untested | Should work with minor adjustments |
| **Windows** | 🚧 Untested | Should work with minor adjustments |

---

## 🛠️ Development Workflow

### Code Generation

BooksTrack uses code generation extensively. Run this after modifying:
- Riverpod providers (`@riverpod` annotations)
- Drift database tables
- Freezed DTOs

```bash
# One-time generation
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate on file changes)
dart run build_runner watch --delete-conflicting-outputs
```

### Code Quality

```bash
# Run analyzer
flutter analyze

# Auto-fix lint issues
dart fix --apply

# Format code
dart format .

# Run tests
flutter test

# Run tests with coverage
flutter test --coverage
```

### Pre-Commit Hook

The repository includes an automated pre-commit hook that:
- ✨ Auto-formats all Dart code
- 🔐 Blocks sensitive files (.jks, .keystore, etc.)
- 🎯 Runs Flutter analyzer
- 🐛 Warns about `print()` statements

The hook is automatically installed via `.git/hooks/pre-commit` → `.claude/hooks/pre-commit.sh`.

---

## 📚 Documentation

**Primary References:**
- **[CLAUDE.md](CLAUDE.md)** - Complete project guide for AI assistants (400+ lines)
- **[MASTER_TODO.md](MASTER_TODO.md)** - Prioritized task list (updated Jan 6, 2026)
- **[docs/README.md](docs/README.md)** - Complete documentation index

**Key Guides:**
- [BendV3 API Integration](docs/api-integration/BENDV3_API_INTEGRATION_GUIDE.md)
- [Linting & Code Quality](docs/setup/LINTING_SETUP.md)
- [DTO Sync Guardrails](docs/api-integration/DTO_SYNC_GUARDRAILS.md)
- [Feature Implementation Plans](docs/planning/features/)

**Architecture References:**
- [Clean Architecture Structure](.github/FLUTTER_ORGANIZATION_PLAN.md)
- [Agent Optimization](.claude/ROBIT_OPTIMIZATION.md)
- [GitHub Labels System](.github/LABELS.md)

---

## 🤝 Contributing

We welcome contributions! To get started:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Make your changes** and ensure tests pass
4. **Run the linter** (`flutter analyze`)
5. **Format your code** (`dart format .`)
6. **Commit your changes** (`git commit -m 'Add amazing feature'`)
7. **Push to the branch** (`git push origin feature/amazing-feature`)
8. **Open a Pull Request**

**Code Standards:**
- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use Material Design 3 components
- Add tests for new features
- Update documentation as needed
- See [LINTING_SETUP.md](docs/setup/LINTING_SETUP.md) for complete quality guidelines

---

## 🎯 Project Status

**Current Phase:** Phase 2 (Search Feature) - 100% UI Complete, API Integration Pending

**Recent Achievements (Jan 6, 2026):**
- ✅ FilterChip Material 3 refactor (PR #5)
- ✅ "Add Books" button navigation fix (PR #10)
- ✅ Performance optimizations with const widgets (PR #11)
- ✅ DTO Sync Guardrails system (5-layer type-safety)
- ✅ BendV3 v3.2.0 API contracts verified

**Next Milestones:**
- Connect Search UI to real BendV3 API
- Implement "Add to Library" functionality
- Add barcode scanner
- Build AI bookshelf scanner

See [MASTER_TODO.md](MASTER_TODO.md) for complete task list.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **Backend API:** Powered by [BendV3](https://api.oooefam.net) (Cloudflare Workers)
- **AI Scanning:** Google Gemini 2.0 Flash
- **Book Data:** Google Books API, Open Library, ISBNdb
- **UI Framework:** Flutter & Material Design 3
- **State Management:** Riverpod by Remi Rousselet

---

## 📞 Support & Feedback

- **Issues:** [GitHub Issues](https://github.com/yourusername/bookstrack-web/issues)
- **Discussions:** [GitHub Discussions](https://github.com/yourusername/bookstrack-web/discussions)
- **Documentation:** [docs/](docs/)

---

**Made with ❤️ using Flutter**
