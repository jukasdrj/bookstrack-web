import 'package:books_tracker/core/data/database/database.dart';
import 'package:books_tracker/features/review_queue/data/repositories/review_queue_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Review queue notifier - manages the list of items to review
class ReviewQueueNotifier extends AsyncNotifier<List<DetectedItem>> {
  @override
  Future<List<DetectedItem>> build() async {
    final repo = ref.watch(reviewQueueRepositoryProvider);
    return repo.getPendingItems();
  }

  Future<void> acceptItem(DetectedItem item) async {
    final repo = ref.read(reviewQueueRepositoryProvider);
    await repo.acceptItem(
      itemId: item.id,
      title: item.titleGuess,
      author: item.authorGuess ?? 'Unknown',
    );
    // Refresh list
    ref.invalidateSelf();
  }

  Future<void> rejectItem(DetectedItem item) async {
    final repo = ref.read(reviewQueueRepositoryProvider);
    await repo.rejectItem(item.id);
    ref.invalidateSelf();
  }
}

/// Provider for the review queue
final reviewQueueProvider =
    AsyncNotifierProvider<ReviewQueueNotifier, List<DetectedItem>>(
      ReviewQueueNotifier.new,
    );
