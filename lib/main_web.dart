import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app/app_web.dart';

/// Web-specific entry point for BooksTrack
///
/// This version uses Firestore exclusively (no local SQLite database)
/// to avoid web compatibility issues with Drift/SQLite FFI.
///
/// **Key Differences from main.dart:**
/// - No local database initialization
/// - Simplified routing (Search only for now)
/// - Firestore-ready for future library features
/// - All state synchronized with Firebase
///
/// **Compatible with mobile apps:**
/// - Mobile uses Drift + Firestore sync (offline-first)
/// - Web uses Firestore only (online-only)
/// - Both read/write to same Firestore collections
///
/// **Features Available on Web:**
/// - ✅ Book search (title, author, ISBN)
/// - ✅ BendV3 API integration
/// - ✅ Material 3 theming
/// - ✅ Responsive layout
/// - 🚧 Library management (coming soon - Firestore integration)
///
/// **Deploy to:** https://books.oooefam.net
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (required for Firestore)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: BooksAppWeb(),
    ),
  );
}
