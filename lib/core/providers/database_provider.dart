import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/database.dart';

/// Provider for the app database instance (no code gen needed)
///
/// **Web Platform:** Returns a stub/mock database since SQLite doesn't work on web.
/// The app uses Firestore exclusively on web instead.
///
/// **Mobile/Desktop:** Returns full AppDatabase with Drift/SQLite.
final databaseProvider = Provider<AppDatabase>((ref) {
  if (kIsWeb) {
    // On web, we can't use SQLite, so we throw if anyone tries to use it
    // The app should use Firestore providers instead on web
    throw UnimplementedError(
      'Database not available on web. Use Firestore providers instead.',
    );
  }

  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// Provider that watches library works with their status
final watchWorksProvider = StreamProvider<List<WorkWithLibraryStatus>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchLibrary();
});

/// Provider that watches the review queue (pending detected items)
final watchReviewQueueProvider = FutureProvider<List<DetectedItem>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.getPendingReviewItems();
});

/// Provider for searching works in the library
final searchWorksProvider = FutureProvider.family<List<WorkWithLibraryStatus>, String>((ref, query) async {
  final db = ref.watch(databaseProvider);
  final entries = await db.watchLibrary(searchQuery: query).first;
  return entries;
});
