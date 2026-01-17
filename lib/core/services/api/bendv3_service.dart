import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/dtos/book_dto.dart';

part 'bendv3_service.g.dart';

/// Service for interacting with the BendV3 API (v3.2.0).
///
/// Provides methods for:
/// - Unified book search (title, author, ISBN, semantic)
/// - Direct ISBN lookup
/// - Batch ISBN enrichment (1-500 ISBNs)
/// - Weekly recommendations (non-personalized)
/// - API capabilities check
///
/// All methods return structured responses with error handling via [DioException].
/// The service uses a 60-second receive timeout to accommodate AI processing delays.
///
/// **Example:**
/// ```dart
/// final service = ref.watch(bendV3ServiceProvider);
/// final results = await service.searchBooks(query: 'Harry Potter');
/// for (final book in results.results) {
///   print('${book.work.title} by ${book.authors.map((a) => a.name).join(", ")}');
/// }
/// ```
///
/// **API Documentation:** https://api.oooefam.net/v3/docs
class BendV3Service {
  final Dio _dio;
  static const String _baseUrl = 'https://api.oooefam.net/v3';

  BendV3Service(this._dio);

  /// Searches for books using the unified search endpoint.
  ///
  /// **Endpoint:** `GET /v3/books/search`
  ///
  /// Supports multiple search types:
  /// - **text** (default) - Traditional keyword search
  /// - **semantic** - AI-powered semantic search
  /// - **similar** - Find similar books
  ///
  /// **Parameters:**
  /// - [query] - Search query (required, non-empty)
  /// - [type] - Search type (text/semantic/similar), defaults to 'text'
  /// - [limit] - Number of results (1-100), defaults to 20
  /// - [offset] - Pagination offset, defaults to 0
  ///
  /// **Returns:** [SearchResponse] with paginated results
  ///
  /// **Throws:**
  /// - [DioException] on network errors
  /// - [Exception] on API errors (non-200 status, success=false)
  ///
  /// **Example:**
  /// ```dart
  /// // Text search
  /// final results = await service.searchBooks(query: 'Dune');
  ///
  /// // Semantic search with pagination
  /// final results = await service.searchBooks(
  ///   query: 'books about space exploration',
  ///   type: 'semantic',
  ///   limit: 50,
  ///   offset: 0,
  /// );
  /// ```
  Future<SearchResponse> searchBooks({
    required String query,
    String type = 'text',
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_baseUrl/books/search',
        queryParameters: {
          'q': query,
          'type': type,
          'limit': limit,
          'offset': offset,
        },
      );

      final responseData = response.data!;
      if (response.statusCode == 200 && responseData['success'] == true) {
        final data = responseData['data'] as Map<String, dynamic>;
        final results = (data['results'] as List)
            .map((json) => BookDTO.fromJson(json as Map<String, dynamic>))
            .toList();

        return SearchResponse(
          results: results,
          total: data['totalCount'] as int,
          limit: data['query']['limit'] as int,
          offset: data['query']['offset'] as int,
        );
      }

      throw Exception('Failed to search books: ${response.statusCode}');
    } catch (e) {
      rethrow;
    }
  }

  /// Retrieves detailed book information by ISBN.
  ///
  /// **Endpoint:** `GET /v3/books/:isbn`
  ///
  /// Accepts both ISBN-10 and ISBN-13 formats. The API automatically
  /// normalizes ISBNs (removes hyphens, validates check digits).
  ///
  /// **Parameters:**
  /// - [isbn] - ISBN-10 or ISBN-13 (with or without hyphens)
  ///
  /// **Returns:**
  /// - [BookDTO] if book found
  /// - `null` if ISBN not found (404 response)
  ///
  /// **Throws:**
  /// - [DioException] on network errors
  /// - [Exception] on API errors (other than 404)
  ///
  /// **Example:**
  /// ```dart
  /// final book = await service.getBookByIsbn('9780439708180');
  /// if (book != null) {
  ///   print('Found: ${book.title}');
  /// } else {
  ///   print('Book not found in database');
  /// }
  /// ```
  Future<BookDTO?> getBookByIsbn(String isbn) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_baseUrl/books/$isbn',
      );

      final responseData = response.data!;
      if (response.statusCode == 200 && responseData['success'] == true) {
        final data = responseData['data'] as Map<String, dynamic>;
        return BookDTO.fromJson(data);
      }

      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      rethrow;
    }
  }

  /// Enriches multiple books by ISBN in a single batch operation.
  ///
  /// **Endpoint:** `POST /v3/books/enrich`
  ///
  /// Efficiently fetches detailed information for up to 500 ISBNs in one request.
  /// The response separates found books from ISBNs not in the database.
  ///
  /// **Parameters:**
  /// - [isbns] - List of ISBN-10 or ISBN-13 strings (1-500 items)
  ///
  /// **Returns:** [EnrichResponse] with:
  /// - `found` - List of [BookDTO] objects for located books
  /// - `notFound` - List of ISBN strings not in the database
  ///
  /// **Throws:**
  /// - [ArgumentError] if isbns list is empty or > 500
  /// - [DioException] on network errors
  /// - [Exception] on API errors
  ///
  /// **Example:**
  /// ```dart
  /// final response = await service.enrichBooks([
  ///   '9780439708180', // Harry Potter
  ///   '9780547928227', // The Hobbit
  ///   '9999999999999', // Invalid ISBN
  /// ]);
  /// print('Found ${response.found.length} books');
  /// print('Missing ${response.notFound.length} ISBNs');
  /// ```
  Future<EnrichResponse> enrichBooks(List<String> isbns) async {
    if (isbns.isEmpty) {
      throw ArgumentError('ISBNs list cannot be empty');
    }

    if (isbns.length > 500) {
      throw ArgumentError('Maximum 500 ISBNs per request');
    }

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '$_baseUrl/books/enrich',
        data: {'isbns': isbns},
      );

      final responseData = response.data!;
      if (response.statusCode == 200 && responseData['success'] == true) {
        final data = responseData['data'] as Map<String, dynamic>;
        return EnrichResponse(
          found: (data['books'] as List)
              .map((json) => BookDTO.fromJson(json as Map<String, dynamic>))
              .toList(),
          notFound: (data['notFound'] as List).cast<String>(),
        );
      }

      throw Exception('Failed to enrich books: ${response.statusCode}');
    } catch (e) {
      rethrow;
    }
  }

  /// Retrieves curated weekly book recommendations.
  ///
  /// **Endpoint:** `GET /v3/recommendations/weekly`
  ///
  /// Returns a curated list of book recommendations that updates every Sunday at
  /// midnight UTC. Recommendations are non-personalized and hand-picked by the
  /// BendV3 team.
  ///
  /// **Parameters:**
  /// - [limit] - Maximum number of recommendations (1-50), defaults to 10
  ///
  /// **Returns:**
  /// - List of [BookDTO] objects
  /// - Empty list if endpoint not yet implemented (404)
  ///
  /// **Throws:**
  /// - [DioException] on network errors (other than 404)
  /// - [Exception] on API errors
  ///
  /// **Note:** This is a v3.2.0 feature (P2 priority). Returns empty list if
  /// endpoint is not available yet.
  ///
  /// **Example:**
  /// ```dart
  /// final recommendations = await service.getWeeklyRecommendations(limit: 5);
  /// if (recommendations.isNotEmpty) {
  ///   print('This week\\'s picks:');
  ///   for (final book in recommendations) {
  ///     print('- ${book.title}');
  ///   }
  /// }
  /// ```
  Future<List<BookDTO>> getWeeklyRecommendations({int limit = 10}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_baseUrl/recommendations/weekly',
        queryParameters: {'limit': limit},
      );

      final responseData = response.data!;
      if (response.statusCode == 200 && responseData['success'] == true) {
        final data = responseData['data'] as Map<String, dynamic>;
        final recommendations = data['recommendations'] as List;
        return recommendations
            .map((json) => BookDTO.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      throw Exception('Failed to get recommendations: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        // Endpoint not implemented yet
        return [];
      }
      rethrow;
    }
  }

  /// Retrieves API capabilities and rate limits.
  ///
  /// **Endpoint:** `GET /v3/capabilities`
  ///
  /// Returns information about available API features, version, rate limits,
  /// and enabled endpoints. Useful for:
  /// - Feature detection (check if endpoints are available)
  /// - Rate limit awareness (prevent hitting limits)
  /// - Version compatibility checking
  ///
  /// **Returns:** Map with capabilities information:
  /// - `version` - API version string (e.g., "3.2.0")
  /// - `features` - List of enabled features
  /// - `rateLimits` - Rate limit configuration
  /// - `endpoints` - Available endpoint URLs
  ///
  /// **Throws:**
  /// - [DioException] on network errors
  /// - [Exception] on API errors
  ///
  /// **Note:** This is a v3.2.0 feature (P3 priority).
  ///
  /// **Example:**
  /// ```dart
  /// final caps = await service.getCapabilities();
  /// print('API Version: ${caps['version']}');
  /// if ((caps['features'] as List).contains('semantic_search')) {
  ///   print('Semantic search is available');
  /// }
  /// ```
  Future<Map<String, dynamic>> getCapabilities() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_baseUrl/capabilities',
      );

      final responseData = response.data!;
      if (response.statusCode == 200 && responseData['success'] == true) {
        return responseData['data'] as Map<String, dynamic>;
      }

      throw Exception('Failed to get capabilities: ${response.statusCode}');
    } catch (e) {
      rethrow;
    }
  }
}

/// Paginated search response from BendV3 API.
///
/// Contains a list of search results along with pagination metadata.
/// Use [total] to determine if there are more pages available.
///
/// **Example:**
/// ```dart
/// final response = await service.searchBooks(query: 'Dune');
/// print('Showing ${response.results.length} of ${response.total} results');
///
/// // Check if there are more pages
/// final hasMore = (response.offset + response.limit) < response.total;
/// if (hasMore) {
///   final nextPage = await service.searchBooks(
///     query: 'Dune',
///     offset: response.offset + response.limit,
///   );
/// }
/// ```
class SearchResponse {
  /// List of book results for this page
  final List<BookDTO> results;

  /// Total number of matching books across all pages
  final int total;

  /// Maximum results per page (requested limit)
  final int limit;

  /// Current page offset (0-indexed)
  final int offset;

  SearchResponse({
    required this.results,
    required this.total,
    required this.limit,
    required this.offset,
  });
}


/// Batch enrichment response from BendV3 API.
///
/// Used by [BendV3Service.enrichBooks] to separate successful lookups
/// from ISBNs not found in the database.
///
/// **Example:**
/// ```dart
/// final response = await service.enrichBooks([
///   '9780439708180', // Harry Potter (found)
///   '9999999999999', // Invalid ISBN (not found)
/// ]);
///
/// // Process found books
/// for (final book in response.found) {
///   print('✓ ${book.title}');
/// }
///
/// // Log missing ISBNs
/// if (response.notFound.isNotEmpty) {
///   print('Missing ${response.notFound.length} ISBNs:');
///   for (final isbn in response.notFound) {
///     print('✗ $isbn');
///   }
/// }
/// ```
class EnrichResponse {
  /// Books successfully found in the database
  final List<BookDTO> found;

  /// ISBNs not found in the database
  final List<String> notFound;

  EnrichResponse({
    required this.found,
    required this.notFound,
  });
}

/// Riverpod provider for BendV3Service
@riverpod
BendV3Service bendV3Service(Ref ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60), // AI processing can be slow
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  return BendV3Service(dio);
}
