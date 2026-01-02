# BooksTrack Web

Flutter web deployment of BooksTrack - AI-powered book tracking application.

## Architecture

- **Frontend**: Flutter Web (hosted on Cloudflare Pages)
- **Backend**: bendv3 API at `https://api.oooefam.net`
- **Database**: Local (Drift) + Cloud (Firebase Firestore)

## Deployment

This repository is configured for automatic deployment to Cloudflare Pages.

### Cloudflare Pages Configuration

**Framework preset**: Flutter
**Build command**: `flutter build web --release`
**Build output directory**: `build/web`

### Environment Setup

No environment variables needed for basic deployment. Firebase configuration is included in the codebase.

## Local Development

```bash
# Install dependencies
flutter pub get

# Run code generation
dart run build_runner build --delete-conflicting-outputs

# Run web app
flutter run -d chrome

# Build for production
flutter build web --release
```

## Backend API

The app communicates with the bendv3 backend API:
- **Base URL**: `https://api.oooefam.net`
- **API Version**: v3
- **Documentation**: https://api.oooefam.net/v3/docs

## Features

- Multi-mode search (Title, Author, ISBN, Advanced)
- Library management with reading status tracking
- AI-powered bookshelf scanning (Gemini 2.0 Flash)
- Reading analytics and diversity insights
- Firebase Authentication
- Cloud sync with Firestore

## Technology Stack

- Flutter 3.x
- Riverpod (State Management)
- Drift (Local Database)
- GoRouter (Navigation)
- Material Design 3
- Firebase (Auth, Firestore, Storage)

## License

MIT
