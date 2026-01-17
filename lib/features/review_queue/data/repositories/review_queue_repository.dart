import 'package:books_tracker/core/data/database/database.dart';
import 'package:books_tracker/core/providers/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewQueueRepository {
  final AppDatabase _db;

  ReviewQueueRepository(this._db);

  Future<List<DetectedItem>> getPendingItems() => _db.getPendingReviewItems();

  Future<void> acceptItem({
    required String itemId,
    required String title,
    required String author,
  }) => _db.acceptDetectedItem(itemId: itemId, title: title, author: author);

  Future<void> rejectItem(String itemId) => _db.rejectDetectedItem(itemId);
}

/// Manual provider for ReviewQueueRepository
final reviewQueueRepositoryProvider = Provider<ReviewQueueRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ReviewQueueRepository(db);
});
