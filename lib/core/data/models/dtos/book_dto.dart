import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_dto.freezed.dart';
part 'book_dto.g.dart';

/// Represents a book from BendV3 V3 API.
///
/// This is a **flat structure** matching the `@bookstrack/schemas` Book schema exactly.
/// BendV3 pre-joins work, edition, and author data into a single object.
///
/// **Contract Source:** `@bookstrack/schemas` v1.0.1+ BookSchema
///
/// **Example BendV3 Response:**
/// ```json
/// {
///   "isbn": "9780439708180",
///   "isbn10": "0439708184",
///   "title": "Harry Potter and the Sorcerer's Stone",
///   "authors": ["J.K. Rowling"],
///   "publisher": "Scholastic Inc.",
///   "publishedDate": "1998-09-01",
///   "description": "...",
///   "pageCount": 309,
///   "categories": ["Fiction", "Fantasy"],
///   "language": "en",
///   "coverUrl": "https://...",
///   "coverUrls": {
///     "large": "https://...",
///     "medium": "https://...",
///     "small": "https://..."
///   },
///   "coverSource": "r2",
///   "thumbnailUrl": "https://...",
///   "workKey": "OL82563W",
///   "editionKey": "OL7353617M",
///   "provider": "alexandria",
///   "quality": 95
/// }
/// ```
///
/// **Note:** `authors` field can be either:
/// - Simple string array: `["J.K. Rowling"]`
/// - Enriched AuthorReference array (Alexandria v2.2.3+)
///
/// For simplicity, this DTO only stores the string array format.
/// Enriched author metadata is flattened to names only.
@freezed
sealed class BookDTO with _$BookDTO {
  const factory BookDTO({
    /// 13-digit ISBN (required)
    required String isbn,

    /// 10-digit ISBN (optional)
    String? isbn10,

    /// Book title (required)
    required String title,

    /// Book subtitle (optional)
    String? subtitle,

    /// Author names (always string array for simplicity)
    @Default([]) List<String> authors,

    /// Publisher name
    String? publisher,

    /// Publication date (ISO 8601 or partial format like "1998")
    String? publishedDate,

    /// Book description/synopsis
    String? description,

    /// Number of pages
    int? pageCount,

    /// Book categories/genres (e.g., ["Fiction", "Fantasy"])
    @Default([]) List<String> categories,

    /// ISO 639-1 language code (e.g., "en")
    @Default('en') String language,

    /// Legacy cover image URL (single size)
    String? coverUrl,

    /// Legacy thumbnail URL (deprecated: use coverUrls.small)
    String? thumbnailUrl,

    /// Multi-size cover URLs (Alexandria v2.2.4+)
    CoverUrls? coverUrls,

    /// Cover source (r2, external, external-fallback)
    String? coverSource,

    /// OpenLibrary work key (e.g., "OL82563W")
    String? workKey,

    /// OpenLibrary edition key (e.g., "OL7353617M")
    String? editionKey,

    /// Data provider (alexandria, google_books, open_library, isbndb)
    @Default('alexandria') String provider,

    /// Data quality score (0-100)
    @Default(95) int quality,
  }) = _BookDTO;

  factory BookDTO.fromJson(Map<String, dynamic> json) {
    // Handle authors field - can be string[] or AuthorReference[]
    final rawAuthors = json['authors'];
    List<String> authors = [];

    if (rawAuthors is List) {
      authors = rawAuthors.map((author) {
        // If author is a string, use it directly
        if (author is String) return author;

        // If author is an AuthorReference object, extract the name
        if (author is Map<String, dynamic> && author['name'] != null) {
          return author['name'] as String;
        }

        return 'Unknown Author';
      }).toList();
    }

    // Create a new BookDTO with flattened authors
    return BookDTO(
      isbn: json['isbn'] as String,
      isbn10: json['isbn10'] as String?,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      authors: authors,
      publisher: json['publisher'] as String?,
      publishedDate: json['publishedDate'] as String?,
      description: json['description'] as String?,
      pageCount: json['pageCount'] as int?,
      categories: (json['categories'] as List<dynamic>?)?.cast<String>() ?? [],
      language: json['language'] as String? ?? 'en',
      coverUrl: json['coverUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      coverUrls: json['coverUrls'] != null
          ? CoverUrls.fromJson(json['coverUrls'] as Map<String, dynamic>)
          : null,
      coverSource: json['coverSource'] as String?,
      workKey: json['workKey'] as String?,
      editionKey: json['editionKey'] as String?,
      provider: json['provider'] as String? ?? 'alexandria',
      quality: json['quality'] as int? ?? 95,
    );
  }
}

/// Multi-size cover images from BendV3 API.
///
/// Alexandria v2.2.4+ returns cover images in multiple sizes for
/// frontend optimization (avoid loading 4K images for thumbnails).
///
/// **Contract Source:** `@bookstrack/schemas` v1.0.1+ CoverUrlsSchema
@freezed
sealed class CoverUrls with _$CoverUrls {
  const factory CoverUrls({
    /// Large cover image (~600px width)
    String? large,

    /// Medium cover image (~300px width)
    String? medium,

    /// Small cover/thumbnail (~100px width)
    String? small,
  }) = _CoverUrls;

  factory CoverUrls.fromJson(Map<String, dynamic> json) =>
      _$CoverUrlsFromJson(json);
}
