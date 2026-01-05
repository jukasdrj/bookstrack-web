import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/dtos/author_dto.dart';
import '../../data/models/dtos/edition_dto.dart';
import '../../data/models/dtos/work_dto.dart';

part 'bendv3_service.g.dart';

/// Service class for interacting with BendV3 API v3.2.0
class BendV3Service {
  final Dio _dio;
  static const String _baseUrl = 'https://api.oooefam.net/v3';

  BendV3Service(this._dio);

  /// Search books using unified search endpoint
  ///
  /// Endpoint: GET /v3/books/search
  ///
  /// Query parameters:
  /// - q: Search query (required)
  /// - type: Search type (text, semantic, similar) - default: text
  /// - limit: Number of results (1-100) - default: 20
  /// - offset: Pagination offset - default: 0
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
            .map((json) => BookResult.fromJson(json as Map<String, dynamic>))
            .toList();

        return SearchResponse(
          results: results,
          total: data['total'] as int,
          limit: data['limit'] as int,
          offset: data['offset'] as int,
        );
      }

      throw Exception('Failed to search books: ${response.statusCode}');
    } catch (e) {
      rethrow;
    }
  }

  /// Get book by ISBN
  ///
  /// Endpoint: GET /v3/books/:isbn
  Future<BookResult?> getBookByIsbn(String isbn) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_baseUrl/books/$isbn',
      );

      final responseData = response.data!;
      if (response.statusCode == 200 && responseData['success'] == true) {
        final data = responseData['data'] as Map<String, dynamic>;
        return BookResult.fromJson(data);
      }

      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      rethrow;
    }
  }

  /// Enrich books by ISBN (batch operation)
  ///
  /// Endpoint: POST /v3/books/enrich
  ///
  /// Body: { "isbns": ["isbn1", "isbn2", ...] }
  /// Maximum: 500 ISBNs per request
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
          found: (data['found'] as List)
              .map((json) => BookResult.fromJson(json as Map<String, dynamic>))
              .toList(),
          notFound: (data['notFound'] as List).cast<String>(),
        );
      }

      throw Exception('Failed to enrich books: ${response.statusCode}');
    } catch (e) {
      rethrow;
    }
  }

  /// Get weekly book recommendations
  ///
  /// Endpoint: GET /v3/recommendations/weekly
  ///
  /// Note: This is a P2 feature - endpoint may not be available yet
  Future<List<BookResult>> getWeeklyRecommendations({int limit = 10}) async {
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
            .map((json) => BookResult.fromJson(json as Map<String, dynamic>))
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

  /// Get API capabilities
  ///
  /// Endpoint: GET /v3/capabilities
  ///
  /// Note: This is a P3 feature
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

/// Search response model
class SearchResponse {
  final List<BookResult> results;
  final int total;
  final int limit;
  final int offset;

  SearchResponse({
    required this.results,
    required this.total,
    required this.limit,
    required this.offset,
  });
}

/// Book result model combining work and edition data
class BookResult {
  final WorkDTO work;
  final EditionDTO? edition;
  final List<AuthorDTO> authors;

  BookResult({
    required this.work,
    this.edition,
    required this.authors,
  });

  factory BookResult.fromJson(Map<String, dynamic> json) {
    return BookResult(
      work: WorkDTO.fromJson(json['work']),
      edition:
          json['edition'] != null ? EditionDTO.fromJson(json['edition']) : null,
      authors: (json['authors'] as List?)
              ?.map((a) => AuthorDTO.fromJson(a))
              .toList() ??
          [],
    );
  }
}

/// Enrich response model
class EnrichResponse {
  final List<BookResult> found;
  final List<String> notFound;

  EnrichResponse({
    required this.found,
    required this.notFound,
  });
}

/// Riverpod provider for BendV3Service
@riverpod
BendV3Service bendV3Service(BendV3ServiceRef ref) {
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
