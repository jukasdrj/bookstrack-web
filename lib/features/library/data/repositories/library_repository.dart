import 'package:books_tracker/core/data/database/database.dart';
import 'package:books_tracker/core/data/models/dtos/edition_dto.dart';
import 'package:books_tracker/core/data/models/dtos/work_dto.dart';
import 'package:books_tracker/core/providers/database_provider.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'library_repository.g.dart';

class LibraryRepository {
  final AppDatabase _db;

  LibraryRepository(this._db);

  Stream<List<WorkWithLibraryStatus>> watchLibrary({
    ReadingStatus? status,
    String? searchQuery,
  }) {
    return _db.watchLibrary(filterStatus: status, searchQuery: searchQuery);
  }

  Future<void> updateStatus(String workId, ReadingStatus status) async {
    await _db.updateWorkStatus(workId: workId, status: status);
  }

  Future<void> addBookFromSearch({
    required WorkDTO work,
    EditionDTO? edition,
    required ReadingStatus status,
  }) async {
    // 1. Insert Work
    await _db.insertWork(
      WorksCompanion.insert(
        id: work.id,
        title: work.title,
        author: Value(work.author),
        subtitle: Value(work.subtitle),
        description: Value(work.description),
        reviewStatus: Value(work.reviewStatus),
        authorIds: work.authorIds,
        subjectTags: work.subjectTags,
        categories: work.categories,
        qualityScore: Value(work.qualityScore),
        synthetic: Value(work.synthetic),
        workKey: Value(work.workKey),
        provider: Value(work.provider),
        updatedAt: Value(DateTime.now()),
      ),
    );

    // 2. Insert Edition if present
    if (edition != null) {
      await _db.insertEdition(
        EditionsCompanion.insert(
          id: edition.id,
          workId: work.id,
          isbn13: Value(edition.isbn13),
          isbn10: Value(edition.isbn10),
          subtitle: Value(edition.subtitle),
          publisher: Value(edition.publisher),
          publishedYear: Value(edition.publishedYear),
          coverImageURL: Value(edition.coverImageURL),
          thumbnailURL: Value(edition.thumbnailURL),
          description: Value(edition.description),
          format: Value(edition.format),
          pageCount: Value(edition.pageCount),
          language: Value(edition.language),
          editionKey: Value(edition.editionKey),
          categories: edition.categories,
          updatedAt: Value(DateTime.now()),
        ),
      );
    }

    // 3. Create Library Entry
    await _db.updateWorkStatus(workId: work.id, status: status);
  }

  Future<void> addToLibrary({
    required String workId,
    required ReadingStatus status,
  }) async {
    await _db.updateWorkStatus(workId: workId, status: status);
  }

  Future<void> removeFromLibrary(String workId) async {
    await _db.deleteLibraryEntry(workId);
  }
}

@riverpod
LibraryRepository libraryRepository(Ref ref) {
  final db = ref.watch(databaseProvider);
  return LibraryRepository(db);
}
