import 'package:flutter/foundation.dart' show debugPrint;

import 'package:books_tracker/core/data/database/database.dart';
import 'package:books_tracker/core/data/models/firestore/user_library_entry_fs.dart';
import 'package:books_tracker/core/domain/repositories/library_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore-backed library repository with offline support
/// Implements offline-first architecture: local Drift cache + cloud sync
class FirestoreLibraryRepository implements LibraryRepository {
  final AppDatabase _localDb;
  final FirebaseFirestore _firestore;

  FirestoreLibraryRepository({
    required AppDatabase localDb,
    required FirebaseFirestore firestore,
  }) : _localDb = localDb,
       _firestore = firestore;

  @override
  Stream<List<Work>> watchLibrary({
    String? userId,
    ReadingStatus? filterStatus,
    String? cursor,
    int limit = 50,
  }) {
    // Local-first: Read from Drift immediately
    final localStream = _localDb.watchLibrary(
      filterStatus: filterStatus,
      cursor: cursor,
      limit: limit,
    );

    // Background sync: Pull latest from Firestore when available
    if (userId != null) {
      _syncFromFirestore(userId).catchError((Object error) {
        // Silent fail - local data still works
        debugPrint('Background sync failed: $error');
      });
    }

    // Map WorkWithLibraryStatus to Work for interface compatibility
    return localStream.map((items) => items.map((item) => item.work).toList());
  }

  @override
  Future<Work?> getWork(String workId, {String? userId}) async {
    // Try local first
    final localWork = await _localDb.getWorkById(workId);
    if (localWork != null) return localWork;

    // Fallback to Firestore if user ID provided
    if (userId != null) {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('library')
          .doc(workId)
          .get();

      if (doc.exists) {
        final entryFS = UserLibraryEntryFS.fromJson(doc.data()!);
        return _convertToWork(entryFS);
      }
    }

    return null;
  }

  @override
  Future<Work> addBook({
    required String userId,
    required Work work,
    Edition? edition,
  }) async {
    // 1. Optimistic local update (instant UI feedback)
    await _localDb.insertWork(work);
    if (edition != null) {
      await _localDb.insertEdition(edition);
    }

    // 2. Queue Firestore sync in background
    _queueFirestoreSync(userId, work, edition);

    return work;
  }

  @override
  Future<void> updateStatus({
    required String userId,
    required String workId,
    required ReadingStatus status,
    DateTime? startedAt,
    DateTime? finishedAt,
  }) async {
    // 1. Update local immediately
    await _localDb.updateWorkStatus(
      workId: workId,
      status: status,
      startedAt: startedAt,
      finishedAt: finishedAt,
    );

    // 2. Sync to Firestore
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('library')
        .doc(workId)
        .update({
          'status': status.name,
          if (startedAt != null) 'startedAt': Timestamp.fromDate(startedAt),
          if (finishedAt != null) 'finishedAt': Timestamp.fromDate(finishedAt),
          'updatedAt': FieldValue.serverTimestamp(),
        });
  }

  @override
  Future<void> updateProgress({
    required String userId,
    required String workId,
    required int currentPage,
  }) async {
    // 1. Update local
    await _localDb.updateWorkProgress(workId: workId, currentPage: currentPage);

    // 2. Sync to Firestore
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('library')
        .doc(workId)
        .update({
          'currentPage': currentPage,
          'updatedAt': FieldValue.serverTimestamp(),
        });
  }

  @override
  Future<void> updateRating({
    required String userId,
    required String workId,
    required int rating,
  }) async {
    // 1. Update local
    await _localDb.updateWorkRating(workId: workId, rating: rating);

    // 2. Sync to Firestore
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('library')
        .doc(workId)
        .update({
          'personalRating': rating,
          'updatedAt': FieldValue.serverTimestamp(),
        });
  }

  @override
  Future<void> updateNotes({
    required String userId,
    required String workId,
    required String notes,
  }) async {
    // 1. Update local
    await _localDb.updateWorkNotes(workId: workId, notes: notes);

    // 2. Sync to Firestore
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('library')
        .doc(workId)
        .update({'notes': notes, 'updatedAt': FieldValue.serverTimestamp()});
  }

  @override
  Future<void> removeBook({
    required String userId,
    required String workId,
  }) async {
    // 1. Remove from local
    await _localDb.deleteWork(workId);

    // 2. Remove from Firestore
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('library')
        .doc(workId)
        .delete();
  }

  @override
  Future<void> syncWithCloud(String userId) async {
    await _syncFromFirestore(userId);
  }

  @override
  Future<List<Work>> exportLibrary(String userId) async {
    return _localDb.getAllWorks();
  }

  @override
  Stream<SyncStatus> watchSyncStatus(String userId) {
    // TODO: Implement sync status tracking
    // For now, return a simple stream
    return Stream.value(const SyncStatus(isSyncing: false, pendingUploads: 0));
  }

  // =========================================================================
  // Private Helper Methods
  // =========================================================================

  /// Background sync: Pull latest from Firestore → Drift
  Future<void> _syncFromFirestore(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('library')
        .orderBy('updatedAt', descending: true)
        .limit(500) // TODO: Pagination for large libraries
        .get();

    for (final doc in snapshot.docs) {
      try {
        final entryFS = UserLibraryEntryFS.fromJson(doc.data());
        final work = _convertToWork(entryFS);

        // Conflict resolution: Use Firestore timestamp as source of truth
        final localWork = await _localDb.getWorkById(work.id);
        final localUpdatedAt = localWork?.updatedAt;
        final remoteUpdatedAt = work.updatedAt;
        if (localWork == null ||
            (localUpdatedAt != null &&
                remoteUpdatedAt != null &&
                localUpdatedAt.isBefore(remoteUpdatedAt))) {
          await _localDb.insertWork(work);
        }
      } catch (e) {
        debugPrint('Failed to sync work ${doc.id}: $e');
      }
    }
  }

  /// Queue Firestore sync in background (fire-and-forget)
  void _queueFirestoreSync(String userId, Work work, Edition? edition) {
    Future(() async {
      try {
        final entryFS = _convertToFirestore(work);
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('library')
            .doc(work.id)
            .set(entryFS.toJson());
      } catch (e) {
        // TODO: Add to retry queue
        debugPrint('Failed to sync to Firestore: $e');
      }
    });
  }

  /// Convert Drift Work → Firestore UserLibraryEntryFS
  UserLibraryEntryFS _convertToFirestore(Work work) {
    return UserLibraryEntryFS(
      workId: work.id,
      title: work.title,
      author: work.author ?? '',
      status: 'toRead', // TODO: Map from ReadingStatus enum
      currentPage: null, // TODO: Get from UserLibraryEntries
      personalRating: null,
      notes: null,
      startedAt: null,
      finishedAt: null,
      createdAt: work.createdAt ?? DateTime.now(),
      updatedAt: work.updatedAt ?? DateTime.now(),
    );
  }

  /// Convert Firestore UserLibraryEntryFS → Drift Work
  Work _convertToWork(UserLibraryEntryFS entryFS) {
    return Work(
      id: entryFS.workId,
      title: entryFS.title,
      author: entryFS.author,
      authorIds: const [],
      subjectTags: const [],
      categories: const [],
      synthetic: false,
      createdAt: entryFS.createdAt,
      updatedAt: entryFS.updatedAt,
    );
  }
}
