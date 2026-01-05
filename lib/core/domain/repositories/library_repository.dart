import 'package:books_tracker/core/data/database/database.dart';

/// Repository interface for library operations
/// Abstracts data source (local Drift vs cloud Firestore)
abstract class LibraryRepository {
  /// Watch user's library with optional filters
  /// Returns a stream of works for reactive UI updates
  Stream<List<Work>> watchLibrary({
    String? userId,
    ReadingStatus? filterStatus,
    String? cursor,
    int limit = 50,
  });

  /// Get a single work by ID
  Future<Work?> getWork(String workId, {String? userId});

  /// Add a book to the library
  /// Performs optimistic local update + queues cloud sync
  Future<Work> addBook({
    required String userId,
    required Work work,
    Edition? edition,
  });

  /// Update reading status (wishlist → reading → read)
  Future<void> updateStatus({
    required String userId,
    required String workId,
    required ReadingStatus status,
    DateTime? startedAt,
    DateTime? finishedAt,
  });

  /// Update reading progress (current page)
  Future<void> updateProgress({
    required String userId,
    required String workId,
    required int currentPage,
  });

  /// Update personal rating (1-5 stars)
  Future<void> updateRating({
    required String userId,
    required String workId,
    required int rating,
  });

  /// Update personal notes
  Future<void> updateNotes({
    required String userId,
    required String workId,
    required String notes,
  });

  /// Remove a book from the library
  Future<void> removeBook({
    required String userId,
    required String workId,
  });

  /// Sync local database with cloud Firestore
  /// Called on app startup and when coming back online
  Future<void> syncWithCloud(String userId);

  /// Export local library for migration
  /// Returns all works for one-time upload to Firestore
  Future<List<Work>> exportLibrary(String userId);

  /// Get sync status (pending uploads, last sync time, etc.)
  Stream<SyncStatus> watchSyncStatus(String userId);
}

/// Sync status for UI indicators
class SyncStatus {
  final bool isSyncing;
  final int pendingUploads;
  final DateTime? lastSyncAt;
  final String? error;

  const SyncStatus({
    required this.isSyncing,
    required this.pendingUploads,
    this.lastSyncAt,
    this.error,
  });

  bool get isOnline => !isSyncing && pendingUploads == 0 && error == null;
  bool get hasError => error != null;
  bool get hasPendingChanges => pendingUploads > 0;
}
