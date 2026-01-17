import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart' as uuid;

import '../models/enums/data_provider.dart';

// Conditional imports for platform-specific database implementations
import 'package:drift/web.dart'; // Web-specific Drift

part 'database.g.dart';

// Type Converters
class ListConverter extends TypeConverter<List<String>, String> {
  const ListConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    return (json.decode(fromDb) as List).cast<String>();
  }

  @override
  String toSql(List<String> value) => json.encode(value);
}

class DataProviderConverter extends TypeConverter<DataProvider?, String?> {
  const DataProviderConverter();

  @override
  DataProvider? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    return DataProvider.values.firstWhere(
      (e) => e.toString().split('.').last == fromDb,
      orElse: () => DataProvider.alexandria,
    );
  }

  @override
  String? toSql(DataProvider? value) {
    if (value == null) return null;
    return value.toString().split('.').last;
  }
}

enum ReadingStatus { wishlist, toRead, reading, read }

// Database Tables
class Works extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get subtitle => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get author => text().nullable()();
  TextColumn get authorIds => text().map(const ListConverter())();
  TextColumn get subjectTags => text().map(const ListConverter())();
  BoolColumn get synthetic => boolean().withDefault(const Constant(false))();
  TextColumn get reviewStatus => text().nullable()();
  TextColumn get workKey => text().nullable()();
  TextColumn get provider =>
      text().map(const DataProviderConverter()).nullable()();
  IntColumn get qualityScore => integer().nullable()();
  TextColumn get categories => text().map(const ListConverter())();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Editions extends Table {
  TextColumn get id => text()();
  TextColumn get workId => text().references(Works, #id)();
  TextColumn get isbn => text().nullable()();
  TextColumn get isbn10 => text().nullable()();
  TextColumn get isbn13 => text().nullable()();
  TextColumn get subtitle => text().nullable()();
  TextColumn get publisher => text().nullable()();
  IntColumn get publishedYear => integer().nullable()();
  TextColumn get coverImageURL => text().nullable()();
  TextColumn get thumbnailURL => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get format => text().nullable()();
  IntColumn get pageCount => integer().nullable()();
  TextColumn get language => text().nullable()();
  TextColumn get editionKey => text().nullable()();
  TextColumn get categories => text().map(const ListConverter())();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Authors extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get gender => text().nullable()();
  TextColumn get culturalRegion => text().nullable()();
  TextColumn get openLibraryId => text().nullable()();
  TextColumn get goodreadsId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class WorkAuthors extends Table {
  TextColumn get workId => text().references(Works, #id)();
  TextColumn get authorId => text().references(Authors, #id)();

  @override
  Set<Column> get primaryKey => {workId, authorId};
}

class UserLibraryEntries extends Table {
  TextColumn get id => text()();
  TextColumn get workId => text().references(Works, #id)();
  TextColumn get editionId => text().references(Editions, #id).nullable()();
  IntColumn get status => intEnum<ReadingStatus>()();
  IntColumn get currentPage => integer().nullable()();
  IntColumn get personalRating => integer().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get finishedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class ScanSessions extends Table {
  TextColumn get id => text()();
  IntColumn get totalDetected => integer()();
  IntColumn get reviewedCount => integer().withDefault(const Constant(0))();
  IntColumn get acceptedCount => integer().withDefault(const Constant(0))();
  IntColumn get rejectedCount => integer().withDefault(const Constant(0))();
  TextColumn get status => text()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class DetectedItems extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text().references(ScanSessions, #id)();
  TextColumn get workId => text().references(Works, #id).nullable()();
  TextColumn get titleGuess => text()();
  TextColumn get authorGuess => text().nullable()();
  RealColumn get confidence => real()();
  TextColumn get imagePath => text()();
  TextColumn get boundingBox => text().nullable()();
  TextColumn get reviewStatus => text()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Database Class
@DriftDatabase(
  tables: [
    Works,
    Editions,
    Authors,
    WorkAuthors,
    UserLibraryEntries,
    ScanSessions,
    DetectedItems,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 5) {
        // Migration from v4 to v5: Add new BendV3 v3.2.0 fields
        // Since we're replacing placeholders, we'll recreate all tables
        await m.createAll();
      }
    },
  );

  // Helper method to watch library with filters
  Stream<List<WorkWithLibraryStatus>> watchLibrary({
    ReadingStatus? filterStatus,
    String? searchQuery,
    String? cursor,
    int limit = 50,
  }) {
    final query = select(userLibraryEntries).join([
      innerJoin(works, works.id.equalsExp(userLibraryEntries.workId)),
      leftOuterJoin(
        editions,
        editions.id.equalsExp(userLibraryEntries.editionId),
      ), // specific edition
    ]);

    if (filterStatus != null) {
      query.where(userLibraryEntries.status.equals(filterStatus.index));
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final term = '%$searchQuery%';
      query.where(works.title.like(term) | works.author.like(term));
    }

    // Sort by most recently updated/added
    query.orderBy([OrderingTerm.desc(userLibraryEntries.updatedAt)]);

    if (limit > 0) {
      query.limit(limit);
    }

    return query.map((row) {
      final work = row.readTable(works);
      final entry = row.readTable(userLibraryEntries);
      final edition = row.readTableOrNull(editions);

      return WorkWithLibraryStatus(
        work: work,
        libraryEntry: entry,
        edition: edition,
      );
    }).watch();
  }

  // Get work by ID
  Future<Work?> getWorkById(String workId) async {
    return (select(works)..where((w) => w.id.equals(workId))).getSingleOrNull();
  }

  // Get all works (for export)
  Future<List<Work>> getAllWorks() async {
    return select(works).get();
  }

  // Insert work (upsert)
  Future<void> insertWork(Insertable<Work> work) async {
    await into(works).insertOnConflictUpdate(work);
  }

  // Insert edition (upsert)
  Future<void> insertEdition(Insertable<Edition> edition) async {
    await into(editions).insertOnConflictUpdate(edition);
  }

  // Update work status
  Future<void> updateWorkStatus({
    required String workId,
    required ReadingStatus status,
    DateTime? startedAt,
    DateTime? finishedAt,
  }) async {
    // Find or create library entry
    final entry = await (select(
      userLibraryEntries,
    )..where((e) => e.workId.equals(workId))).getSingleOrNull();

    if (entry != null) {
      await (update(
        userLibraryEntries,
      )..where((e) => e.id.equals(entry.id))).write(
        UserLibraryEntriesCompanion(
          status: Value(status),
          startedAt: Value(startedAt),
          finishedAt: Value(finishedAt),
          updatedAt: Value(DateTime.now()),
        ),
      );
    } else {
      // Create new entry
      await into(userLibraryEntries).insert(
        UserLibraryEntriesCompanion.insert(
          id: const uuid.Uuid().v4(),
          workId: workId,
          status: status,
          startedAt: Value(startedAt),
          finishedAt: Value(finishedAt),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  // Update work progress
  Future<void> updateWorkProgress({
    required String workId,
    required int currentPage,
  }) async {
    final entry = await (select(
      userLibraryEntries,
    )..where((e) => e.workId.equals(workId))).getSingleOrNull();

    if (entry != null) {
      await (update(
        userLibraryEntries,
      )..where((e) => e.id.equals(entry.id))).write(
        UserLibraryEntriesCompanion(
          currentPage: Value(currentPage),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  // Update work rating
  Future<void> updateWorkRating({
    required String workId,
    required int rating,
  }) async {
    final entry = await (select(
      userLibraryEntries,
    )..where((e) => e.workId.equals(workId))).getSingleOrNull();

    if (entry != null) {
      await (update(
        userLibraryEntries,
      )..where((e) => e.id.equals(entry.id))).write(
        UserLibraryEntriesCompanion(
          personalRating: Value(rating),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  // Update work notes
  Future<void> updateWorkNotes({
    required String workId,
    required String notes,
  }) async {
    final entry = await (select(
      userLibraryEntries,
    )..where((e) => e.workId.equals(workId))).getSingleOrNull();

    if (entry != null) {
      await (update(
        userLibraryEntries,
      )..where((e) => e.id.equals(entry.id))).write(
        UserLibraryEntriesCompanion(
          notes: Value(notes),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  // Delete work
  Future<void> deleteWork(String workId) async {
    await (delete(works)..where((w) => w.id.equals(workId))).go();
  }

  // Delete library entry (remove from library)
  Future<void> deleteLibraryEntry(String workId) async {
    await (delete(
      userLibraryEntries,
    )..where((e) => e.workId.equals(workId))).go();
  }

  // Statistics Queries
  Future<int> countBooksByStatus(ReadingStatus status) async {
    final count = userLibraryEntries.id.count();
    final query = selectOnly(userLibraryEntries)..addColumns([count]);
    query.where(userLibraryEntries.status.equals(status.index));
    return await query.map((row) => row.read(count)).getSingle() ?? 0;
  }

  Future<int> countTotalPagesRead() async {
    final readEntries = await (select(
      userLibraryEntries,
    )..where((e) => e.status.equals(ReadingStatus.read.index))).get();

    int totalPages = 0;
    for (final entry in readEntries) {
      final edition =
          await (select(editions)
                ..where((e) => e.workId.equals(entry.workId))
                ..limit(1))
              .getSingleOrNull();
      if (edition?.pageCount != null) {
        totalPages += edition!.pageCount!;
      }
    }
    return totalPages;
  }

  // Review Queue Queries
  Future<List<DetectedItem>> getPendingReviewItems() async {
    return (select(detectedItems)
          ..where((t) => t.reviewStatus.equals('pending'))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<void> rejectDetectedItem(String itemId) async {
    await (update(detectedItems)..where((t) => t.id.equals(itemId))).write(
      DetectedItemsCompanion(
        reviewStatus: const Value('rejected'),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> acceptDetectedItem({
    required String itemId,
    required String title,
    required String author,
    String? coverImage,
  }) async {
    return transaction(() async {
      // 1. Create Work
      final newWorkId = const uuid.Uuid().v4();
      await insertWork(
        WorksCompanion(
          id: Value(newWorkId),
          title: Value(title),
          author: Value(author),
          synthetic: const Value(true), // Mark as AI-created
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

      // 2. Add to Library
      await into(userLibraryEntries).insert(
        UserLibraryEntriesCompanion.insert(
          id: const uuid.Uuid().v4(),
          workId: newWorkId,
          status: ReadingStatus.toRead,
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

      // 3. Update Detected Item
      await (update(detectedItems)..where((t) => t.id.equals(itemId))).write(
        DetectedItemsCompanion(
          reviewStatus: const Value('accepted'),
          workId: Value(newWorkId),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  // Debug: Seed items
  Future<void> seedDebugItems() async {
    final sessionId = const uuid.Uuid().v4();
    await into(scanSessions).insert(
      ScanSessionsCompanion.insert(
        id: sessionId,
        totalDetected: 2,
        status: 'completed',
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );

    await into(detectedItems).insert(
      DetectedItemsCompanion.insert(
        id: const uuid.Uuid().v4(),
        sessionId: sessionId,
        titleGuess: 'The Great Gatsby',
        authorGuess: const Value('F. Scott Fitzgerald'),
        confidence: 0.95,
        imagePath: '/tmp/gatsby.jpg', // Placeholder
        reviewStatus: 'pending',
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );

    await into(detectedItems).insert(
      DetectedItemsCompanion.insert(
        id: const uuid.Uuid().v4(),
        sessionId: sessionId,
        titleGuess: 'Unknown Book',
        authorGuess: const Value('Unknown Author'),
        confidence: 0.45,
        imagePath: '/tmp/unknown.jpg',
        reviewStatus: 'pending',
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

// Helper class for library status
class WorkWithLibraryStatus {
  final Work work;
  final Edition? edition;
  final UserLibraryEntry? libraryEntry;

  const WorkWithLibraryStatus({
    required this.work,
    this.edition,
    this.libraryEntry,
  });

  // Computed properties for UI convenience
  String get id => work.id;
  String get title => work.title;
  String? get subtitle => work.subtitle;
  String? get author => work.author;
  ReadingStatus? get status => libraryEntry?.status;
  String? get coverImageURL => edition?.coverImageURL;
  String? get thumbnailURL => edition?.thumbnailURL;

  // Display author (prefer work author, fallback to computed from authors table)
  String get displayAuthor => work.author ?? 'Unknown Author';

  // Reading progress (current page / total pages)
  double? get readingProgress {
    final currentPage = libraryEntry?.currentPage;
    final totalPages = edition?.pageCount;

    if (currentPage != null && totalPages != null && totalPages > 0) {
      return currentPage / totalPages;
    }
    return null;
  }
}

/// Opens a connection to the database.
/// For web platforms, uses IndexedDB via sqlite3_web.
/// For native platforms (iOS, Android, macOS), uses NativeDatabase with file storage.
QueryExecutor _openConnection() {
  // For web platforms, use IndexedDB-backed database
  return WebDatabase('bookstrack_db', logStatements: false);
}
