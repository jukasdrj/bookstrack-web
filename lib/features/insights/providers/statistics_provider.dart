import 'package:books_tracker/features/insights/data/repositories/statistics_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatisticsData {
  final int booksRead;
  final int booksToRead;
  final int totalPagesRead;

  const StatisticsData({
    required this.booksRead,
    required this.booksToRead,
    required this.totalPagesRead,
  });
}

/// Provider for statistics data
final statisticsProvider = FutureProvider<StatisticsData>((ref) async {
  final repository = ref.watch(statisticsRepositoryProvider);

  final booksRead = await repository.getBooksReadCount();
  final booksToRead = await repository.getBooksToReadCount();
  final totalPages = await repository.getTotalPagesRead();

  return StatisticsData(
    booksRead: booksRead,
    booksToRead: booksToRead,
    totalPagesRead: totalPages,
  );
});
