import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../models/enums/data_provider.dart';

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

enum ReadingStatus {
  wishlist,
  toRead,
  reading,
  read,
}

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
@DriftDatabase(tables: [
  Works,
  Editions,
  Authors,
  WorkAuthors,
  UserLibraryEntries,
  ScanSessions,
  DetectedItems,
])
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
    String? cursor,
    int limit = 50,
  }) {
    // Placeholder - will be implemented with proper query
    return const Stream.empty();
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

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'bookstrack.sqlite'));
    return NativeDatabase(file);
  });
}
