import 'package:drift/drift.dart';

import '../services/api/bendv3_service.dart';
import 'database/database.dart';
import 'models/dtos/author_dto.dart';
import 'models/dtos/edition_dto.dart';
import 'models/dtos/work_dto.dart';

/// DTOMapper - Converts API DTOs to Drift database models
/// Handles deduplication, synthetic works, and relationship creation
class DTOMapper {

  /// Map SearchResponse to Drift models and insert into database
  static Future<List<Work>> mapAndInsertSearchResponse(
    SearchResponse searchResponse,
    AppDatabase database,
  ) async {
    final List<Work> insertedWorks = [];

    // Process each book result
    for (final bookResult in searchResponse.results) {
      final workDTO = bookResult.work;
      final editionDTO = bookResult.edition;
      final authorDTOs = bookResult.authors;

      // Check for duplicates (synthetic works with same ISBN)
      if (workDTO.synthetic && editionDTO?.isbn != null) {
        final existing = await _findWorkByISBN(editionDTO!.isbn!, database);
        if (existing != null) {
          // Work already exists, skip
          continue;
        }
      }

      // Insert work, authors, and edition in a transaction
      await database.transaction(() async {
        // Insert work
        final workCompanion = _mapWorkDTOToCompanion(workDTO, authorDTOs);
        await database.into(database.works).insert(
              workCompanion,
              mode: InsertMode.insertOrReplace,
            );

        // Insert authors
        for (final authorDTO in authorDTOs) {
          final authorCompanion = _mapAuthorDTOToCompanion(authorDTO);
          await database.into(database.authors).insert(
                authorCompanion,
                mode: InsertMode.insertOrReplace,
              );

          // Create work-author relationship
          await database.into(database.workAuthors).insert(
                WorkAuthorsCompanion.insert(
                  workId: workDTO.id,
                  authorId: authorDTO.id,
                ),
                mode: InsertMode.insertOrReplace,
              );
        }

        // Insert edition if present
        if (editionDTO != null) {
          final editionCompanion = _mapEditionDTOToCompanion(
            editionDTO,
            workDTO.id,
          );
          await database.into(database.editions).insert(
                editionCompanion,
                mode: InsertMode.insertOrReplace,
              );
        }
      });

      // Fetch the inserted work
      final insertedWork = await (database.select(database.works)
            ..where((t) => t.id.equals(workDTO.id)))
          .getSingle();
      insertedWorks.add(insertedWork);
    }

    return insertedWorks;
  }

  /// Map WorkDTO to WorksCompanion
  static WorksCompanion _mapWorkDTOToCompanion(
    WorkDTO dto,
    List<AuthorDTO> authors,
  ) {
    // Join author names with comma separator
    final authorNames = authors.map((a) => a.name).join(', ');

    return WorksCompanion.insert(
      id: dto.id, // Use API-provided ID instead of generating UUID
      title: dto.title,
      authorIds: dto.authorIds,
      subjectTags: dto.subjectTags,
      categories: dto.categories,
      subtitle: Value(dto.subtitle),
      description: Value(dto.description),
      author: Value(authorNames.isNotEmpty ? authorNames : null),
      synthetic: Value(dto.synthetic),
      reviewStatus: Value(dto.reviewStatus),
      workKey: Value(dto.workKey),
      provider: Value(dto.provider),
      qualityScore: Value(dto.qualityScore),
      createdAt: Value(dto.createdAt ?? DateTime.now()),
      updatedAt: Value(dto.updatedAt ?? DateTime.now()),
    );
  }

  /// Map EditionDTO to EditionsCompanion
  static EditionsCompanion _mapEditionDTOToCompanion(
    EditionDTO dto,
    String workId,
  ) {
    return EditionsCompanion.insert(
      id: dto.id, // Use API-provided ID
      workId: workId,
      categories: dto.categories,
      isbn: Value(dto.isbn),
      isbn10: Value(dto.isbn10),
      isbn13: Value(dto.isbn13),
      subtitle: Value(dto.subtitle),
      publisher: Value(dto.publisher),
      publishedYear: Value(dto.publishedYear),
      coverImageURL: Value(dto.coverImageURL),
      thumbnailURL: Value(dto.thumbnailURL),
      description: Value(dto.description),
      format: Value(dto.format),
      pageCount: Value(dto.pageCount),
      language: Value(dto.language),
      editionKey: Value(dto.editionKey),
      createdAt: Value(dto.createdAt ?? DateTime.now()),
      updatedAt: Value(dto.updatedAt ?? DateTime.now()),
    );
  }

  /// Map AuthorDTO to AuthorsCompanion
  static AuthorsCompanion _mapAuthorDTOToCompanion(AuthorDTO dto) {
    return AuthorsCompanion.insert(
      id: dto.id, // Use backend-provided ID (not UUID)
      name: dto.name,
      gender: Value(dto.gender),
      culturalRegion: Value(dto.culturalRegion),
      openLibraryId: Value(dto.openLibraryId),
      goodreadsId: Value(dto.goodreadsId),
      createdAt: Value(dto.createdAt ?? DateTime.now()),
      updatedAt: Value(dto.updatedAt ?? DateTime.now()),
    );
  }

  /// Find work by ISBN (for deduplication)
  static Future<Work?> _findWorkByISBN(
      String isbn, AppDatabase database) async {
    // Find edition with this ISBN
    final edition = await (database.select(database.editions)
          ..where((t) => t.isbn.equals(isbn)))
        .getSingleOrNull();

    if (edition == null) return null;

    // Get the work for this edition
    return await (database.select(database.works)
          ..where((t) => t.id.equals(edition.workId)))
        .getSingleOrNull();
  }
}
