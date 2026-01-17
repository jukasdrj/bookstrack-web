import 'package:drift/drift.dart';

import '../services/api/bendv3_service.dart';
import 'database/database.dart';
import 'models/dtos/author_dto.dart';
import 'models/dtos/edition_dto.dart';
import 'models/dtos/work_dto.dart';

/// Maps BendV3 API DTOs to Drift database models with transactional safety.
///
/// This mapper handles the complex transformation from BendV3's [BookResult] format
/// to the app's normalized database schema. It ensures data integrity through:
///
/// **Key Responsibilities:**
/// 1. **Work Mapping** - Converts WorkDTO → Works table
///    - Uses API-provided IDs (no UUID generation)
///    - Maps v3.2.0 fields (subtitle, description, qualityScore, provider, etc.)
///    - Denormalizes author names for display
///
/// 2. **Author Relationships** - Many-to-many work-author mapping
///    - Uses WorkAuthors junction table
///    - Prevents duplicate author entries (insertOrReplace mode)
///    - Relies on `workDTO.authorIds` for correct relationships
///
/// 3. **Edition Mapping** - Converts EditionDTO → Editions table
///    - Links to parent work via workId foreign key
///    - Supports multiple editions per work
///    - Maps v3.2.0 fields (thumbnailURL, editionKey, etc.)
///
/// 4. **Deduplication** - Prevents duplicate synthetic works
///    - Checks for existing works with same ISBN
///    - Skips insertion if duplicate found
///
/// 5. **Transactional Safety** - Uses `database.transaction()` to ensure:
///    - All-or-nothing inserts (prevents partial data)
///    - Foreign key integrity maintained
///    - Safe concurrent access
///
/// **Performance Considerations:**
/// - Uses `insertOrReplace` to handle duplicates efficiently
/// - Batch processing in single transaction per book
/// - Indexes on foreign keys optimize lookups
///
/// **Example:**
/// ```dart
/// final response = await bendv3Service.searchBooks(query: 'Dune');
/// final works = await DTOMapper.mapAndInsertSearchResponse(
///   response,
///   database: database,
/// );
/// print('Inserted ${works.length} works into database');
/// ```
class DTOMapper {
  /// Maps and inserts a [SearchResponse] into the database.
  ///
  /// Processes all [BookResult] objects in the response, inserting works,
  /// editions, authors, and work-author relationships transactionally.
  ///
  /// **Parameters:**
  /// - [searchResponse] - Response from [BendV3Service.searchBooks]
  /// - [database] - Drift database instance
  ///
  /// **Returns:** List of inserted [Work] objects (excluding duplicates)
  ///
  /// **Deduplication:** Skips synthetic works if an existing work with the
  /// same ISBN is already in the database.
  ///
  /// **Transaction:** Each book result is inserted in its own transaction
  /// (work + authors + relationships + edition).
  // TODO: Update this method to work with BookDTO instead of BookResult
  // Temporarily commented out to allow testing of search functionality
  /*
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
  */

  /// Converts a [WorkDTO] to a Drift [WorksCompanion] for database insertion.
  ///
  /// **Key Mappings:**
  /// - Uses `dto.id` from API (NOT generated UUID)
  /// - Denormalizes author names into `author` field for display
  /// - Maps all v3.2.0 fields (subtitle, description, workKey, provider, qualityScore)
  /// - Sets `createdAt`/`updatedAt` to DTO values or current time
  ///
  /// **Parameters:**
  /// - [dto] - Work DTO from BendV3 API
  /// - [authors] - List of authors for denormalization
  ///
  /// **Returns:** [WorksCompanion] ready for insertion
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

  /// Converts an [EditionDTO] to a Drift [EditionsCompanion] for database insertion.
  ///
  /// **Key Mappings:**
  /// - Uses `dto.id` from API (NOT generated UUID)
  /// - Links to parent work via [workId] foreign key
  /// - Maps all v3.2.0 fields (subtitle, thumbnailURL, editionKey, description)
  /// - Handles all three ISBN formats (isbn, isbn10, isbn13)
  ///
  /// **Parameters:**
  /// - [dto] - Edition DTO from BendV3 API
  /// - [workId] - Parent work ID for foreign key
  ///
  /// **Returns:** [EditionsCompanion] ready for insertion
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

  /// Converts an [AuthorDTO] to a Drift [AuthorsCompanion] for database insertion.
  ///
  /// **Key Mappings:**
  /// - Uses `dto.id` from API (NOT generated UUID)
  /// - Maps diversity fields (gender, culturalRegion)
  /// - Maps external IDs (openLibraryId, goodreadsId)
  ///
  /// **Parameters:**
  /// - [dto] - Author DTO from BendV3 API
  ///
  /// **Returns:** [AuthorsCompanion] ready for insertion
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

  /// Finds an existing work by ISBN for deduplication purposes.
  ///
  /// Used to prevent inserting duplicate synthetic works. Searches for an
  /// edition with the given ISBN, then returns its parent work.
  ///
  /// **Process:**
  /// 1. Query Editions table for matching ISBN
  /// 2. If found, query Works table using edition's workId
  /// 3. Return work if found, null otherwise
  ///
  /// **Parameters:**
  /// - [isbn] - ISBN to search for (ISBN-10 or ISBN-13)
  /// - [database] - Drift database instance
  ///
  /// **Returns:**
  /// - [Work] if a book with this ISBN exists
  /// - `null` if no match found
  static Future<Work?> _findWorkByISBN(
    String isbn,
    AppDatabase database,
  ) async {
    // Find edition with this ISBN
    final edition = await (database.select(
      database.editions,
    )..where((t) => t.isbn.equals(isbn))).getSingleOrNull();

    if (edition == null) return null;

    // Get the work for this edition
    return await (database.select(
      database.works,
    )..where((t) => t.id.equals(edition.workId))).getSingleOrNull();
  }
}
