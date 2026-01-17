import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:books_tracker/core/data/database/database.dart';
import '../../../core/providers/database_provider.dart';

part 'book_actions_provider.g.dart';

/// Provider for book-related actions (add, update status, delete, etc.)
@riverpod
class BookActions extends _$BookActions {
  @override
  FutureOr<void> build() {}

  /// Add a book to the library with a specific status
  Future<void> addToLibrary({
    required String workId,
    ReadingStatus status = ReadingStatus.wishlist,
  }) async {
    final database = ref.read(databaseProvider);
    await database.updateWorkStatus(workId: workId, status: status);
  }

  /// Update reading status
  Future<void> updateReadingStatus(
    String workId,
    ReadingStatus newStatus,
  ) async {
    final database = ref.read(databaseProvider);
    await database.updateWorkStatus(workId: workId, status: newStatus);
  }

  /// Update current page
  Future<void> updateCurrentPage(String workId, int page) async {
    final database = ref.read(databaseProvider);
    await database.updateWorkProgress(workId: workId, currentPage: page);
  }

  /// Update personal rating (1-5 stars)
  Future<void> updateRating(String workId, int rating) async {
    if (rating < 1 || rating > 5) {
      throw ArgumentError('Rating must be between 1 and 5');
    }
    final database = ref.read(databaseProvider);
    await database.updateWorkRating(workId: workId, rating: rating);
  }

  /// Update notes
  Future<void> updateNotes(String workId, String notes) async {
    final database = ref.read(databaseProvider);
    await database.updateWorkNotes(workId: workId, notes: notes);
  }

  /// Delete from library
  Future<void> deleteFromLibrary(String workId) async {
    final database = ref.read(databaseProvider);
    await database.deleteLibraryEntry(workId);
  }
}
