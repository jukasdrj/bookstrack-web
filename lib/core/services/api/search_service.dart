import 'package:dio/dio.dart';

import '../../data/models/dtos/book_dto.dart';
import 'bendv3_service.dart' show SearchResponse;

/// Simple wrapper around BendV3Service for backward compatibility.
///
/// **DEPRECATED:** Use [BendV3Service] directly instead.
///
/// This service provides a simple adapter for the search feature to use
/// BendV3Service without changing the existing search provider interface.
class SearchService {
  final BendV3Service _bendV3;

  SearchService(Dio dio) : _bendV3 = BendV3Service(dio);

  /// Search books by title using BendV3 unified search.
  Future<ResponseEnvelope<SearchResultData>> searchByTitle(String query) async {
    try {
      final response = await _bendV3.searchBooks(query: query);
      return ResponseEnvelope(
        success: true,
        data: SearchResultData(
          books: response.results,
          total: response.total,
          limit: response.limit,
          offset: response.offset,
        ),
        meta: ResponseMeta(cached: false),
      );
    } on DioException {
      rethrow;
    } catch (e) {
      return ResponseEnvelope(
        success: false,
        meta: ResponseMeta(cached: false),
      );
    }
  }

  /// Search books by author using BendV3 unified search.
  ///
  /// **Note:** BendV3 doesn't have a dedicated author search mode,
  /// so this uses the same text search as searchByTitle.
  Future<ResponseEnvelope<SearchResultData>> searchByAuthor(String query) async {
    return searchByTitle(query); // BendV3 uses unified search
  }

  /// Search book by ISBN using BendV3 direct ISBN lookup.
  Future<ResponseEnvelope<SearchResultData>> searchByISBN(String isbn) async {
    try {
      final book = await _bendV3.getBookByIsbn(isbn);

      if (book == null) {
        // Book not found
        return ResponseEnvelope<SearchResultData>(
          success: true,
          data: SearchResultData(
            books: [],
            total: 0,
            limit: 1,
            offset: 0,
          ),
          meta: ResponseMeta(cached: false),
        );
      }

      return ResponseEnvelope<SearchResultData>(
        success: true,
        data: SearchResultData(
          books: [book],
          total: 1,
          limit: 1,
          offset: 0,
        ),
        meta: ResponseMeta(cached: false),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        // Book not found - return empty results
        return ResponseEnvelope<SearchResultData>(
          success: true,
          data: SearchResultData(
            books: [],
            total: 0,
            limit: 1,
            offset: 0,
          ),
          meta: ResponseMeta(cached: false),
        );
      }
      rethrow;
    } catch (e) {
      return ResponseEnvelope(
        success: false,
        meta: ResponseMeta(cached: false),
      );
    }
  }
}

/// Adapter for BendV3Service to maintain backward compatibility.
class BendV3Service {
  final Dio _dio;
  static const String _baseUrl = 'https://api.oooefam.net/v3';

  BendV3Service(this._dio);

  Future<SearchResponse> searchBooks({
    required String query,
    String type = 'text',
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '$_baseUrl/books/search',
      queryParameters: {
        'q': query,
        'mode': type, // V3 uses 'mode' not 'type'
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
  }

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
}

/// Response envelope for search results.
class ResponseEnvelope<T> {
  final bool success;
  final T? data;
  final ResponseMeta meta;

  ResponseEnvelope({
    required this.success,
    this.data,
    required this.meta,
  });
}

/// Response metadata.
class ResponseMeta {
  final bool cached;

  ResponseMeta({required this.cached});
}

/// Search result data.
class SearchResultData {
  final List<BookDTO> books;
  final int total;
  final int limit;
  final int offset;

  SearchResultData({
    required this.books,
    required this.total,
    required this.limit,
    required this.offset,
  });
}
