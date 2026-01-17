import 'package:books_tracker/core/data/database/database.dart';
import 'package:books_tracker/core/providers/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatisticsRepository {
  final AppDatabase _db;

  StatisticsRepository(this._db);

  Future<int> getBooksReadCount() => _db.countBooksByStatus(ReadingStatus.read);

  Future<int> getBooksToReadCount() =>
      _db.countBooksByStatus(ReadingStatus.toRead);

  Future<int> getTotalPagesRead() => _db.countTotalPagesRead();
}

/// Provider for statistics repository
final statisticsRepositoryProvider = Provider<StatisticsRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return StatisticsRepository(db);
});
