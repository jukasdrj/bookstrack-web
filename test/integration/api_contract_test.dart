import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:books_tracker/core/data/models/dtos/work_dto.dart';
import 'package:books_tracker/core/data/models/dtos/edition_dto.dart';
import 'package:books_tracker/core/data/models/dtos/author_dto.dart';

// Tags for organizing integration tests
@Tags(['integration', 'contract'])

/// **API Contract Integration Tests**
///
/// These tests validate that BendV3 API responses match our DTO expectations.
/// Run against staging/production to catch schema drift early.
///
/// Usage:
///   flutter test test/integration/api_contract_test.dart
///
/// Environment:
///   API_BASE_URL=https://api.oooefam.net (default)
///   API_BASE_URL=https://staging-api.oooefam.net (staging)
void main() {
  group('BendV3 API Contract Validation', () {
    late Dio dio;

    setUp(() {
      final baseUrl = const String.fromEnvironment('API_BASE_URL',
          defaultValue: 'https://api.oooefam.net');
      dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: const Duration(seconds: 30),
      ));
    });

    test('GET /v3/books/:isbn returns valid Book schema', () async {
      // Test with Harry Potter ISBN
      final response = await dio.get('/v3/books/9780439708180');

      expect(response.statusCode, 200);
      expect(response.data['success'], true);

      final bookData = response.data['data'] as Map<String, dynamic>;

      // Validate required fields per BookSchema
      expect(bookData['isbn'], isA<String>());
      expect(bookData['isbn'].length, 13);
      expect(bookData['title'], isA<String>());
      expect(bookData['authors'], isA<List>());
      expect(bookData['provider'],
          isIn(['alexandria', 'google_books', 'open_library', 'isbndb']));
      expect(bookData['quality'], isA<num>());
      expect(bookData['quality'], inInclusiveRange(0, 100));

      // Validate optional fields are typed correctly
      if (bookData.containsKey('subtitle')) {
        expect(bookData['subtitle'], isA<String>());
      }
      if (bookData.containsKey('pageCount')) {
        expect(bookData['pageCount'], isA<num>());
      }
      if (bookData.containsKey('coverUrl')) {
        expect(bookData['coverUrl'], isA<String>());
        expect(Uri.tryParse(bookData['coverUrl']), isNotNull);
      }
    });

    test('GET /v3/books/search returns valid BookSearchResults schema',
        () async {
      final response = await dio.get('/v3/books/search', queryParameters: {
        'q': 'harry potter',
        'limit': 10,
      });

      expect(response.statusCode, 200);
      expect(response.data['success'], true);

      final data = response.data['data'] as Map<String, dynamic>;
      expect(data['books'], isA<List>());
      expect(data['total'], isA<num>());
      expect(data['page'], isA<num>());
      expect(data['limit'], isA<num>());

      // Validate first book matches schema
      if ((data['books'] as List).isNotEmpty) {
        final firstBook = data['books'][0] as Map<String, dynamic>;
        expect(firstBook['isbn'], isA<String>());
        expect(firstBook['title'], isA<String>());
        expect(firstBook['authors'], isA<List>());
      }
    });

    test('Error responses match ErrorResponseSchema', () async {
      try {
        await dio.get('/v3/books/0000000000000');
        fail('Expected 404 error');
      } on DioException catch (e) {
        expect(e.response?.statusCode, 404);

        final errorData = e.response?.data as Map<String, dynamic>;
        expect(errorData['success'], false);
        expect(errorData['error'], isA<Map>());

        final error = errorData['error'] as Map<String, dynamic>;
        expect(error['code'], isA<String>());
        expect(error['message'], isA<String>());
        expect(error['statusCode'], 404);
      }
    });

    group('DTO Deserialization from Real API', () {
      test('Book → EditionDTO + WorkDTO mapping', () async {
        final response = await dio.get('/v3/books/9780439708180');
        final bookData = response.data['data'] as Map<String, dynamic>;

        // Map Book → EditionDTO
        final editionJson = {
          'id': bookData['isbn'], // Use ISBN as temporary ID
          'workId': bookData['workKey'] ?? 'unknown',
          'isbn': bookData['isbn'],
          'isbn10': bookData['isbn10'],
          'isbn13': bookData['isbn'], // BendV3 uses 'isbn' for ISBN-13
          'subtitle': bookData['subtitle'],
          'publisher': bookData['publisher'],
          'publishedYear': _parseYear(bookData['publishedDate']),
          'coverImageURL': bookData['coverUrl'],
          'thumbnailURL': bookData['thumbnailUrl'],
          'description': bookData['description'],
          'pageCount': bookData['pageCount'],
          'language': bookData['language'],
          'editionKey': bookData['editionKey'],
          'categories': bookData['categories'] ?? [],
        };

        // Validate DTO can deserialize
        final edition = EditionDTO.fromJson(editionJson);
        expect(edition.isbn, '9780439708180');
        expect(edition.coverImageURL, isNotNull);

        // Map Book → WorkDTO
        final workJson = {
          'id': bookData['workKey'] ?? 'temp-id',
          'title': bookData['title'],
          'subtitle': bookData['subtitle'],
          'description': bookData['description'],
          'author': (bookData['authors'] as List).join(', '),
          'authorIds': <String>[], // Requires separate author mapping
          'subjectTags': bookData['categories'] ?? [],
          'workKey': bookData['workKey'],
          'provider': bookData['provider'],
          'qualityScore': bookData['quality'],
          'categories': bookData['categories'] ?? [],
        };

        final work = WorkDTO.fromJson(workJson);
        expect(work.title, 'Harry Potter and the Sorcerers Stone');
        expect(work.provider.toString(), contains('alexandria'));
      });
    });
  });
}

/// Parse year from ISO 8601 or partial date string
int? _parseYear(dynamic dateStr) {
  if (dateStr == null) return null;
  if (dateStr is! String) return null;
  final match = RegExp(r'(\d{4})').firstMatch(dateStr);
  return match != null ? int.parse(match.group(1)!) : null;
}
