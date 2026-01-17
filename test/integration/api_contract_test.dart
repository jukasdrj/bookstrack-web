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
/// BendV3 API Response Format:
/// ```json
/// {
///   "success": true,
///   "data": {
///     "work": { "id": "...", "title": "...", ... },
///     "edition": { "id": "...", "isbn": "...", ... },
///     "authors": [{ "id": "...", "name": "...", ... }]
///   }
/// }
/// ```
///
/// Usage:
///   flutter test test/integration/api_contract_test.dart
///
/// Environment:
///   API_BASE_URL=https://api.oooefam.net (default)
void main() {
  group('BendV3 API Contract Validation', () {
    late Dio dio;

    setUp(() {
      final baseUrl = const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'https://api.oooefam.net',
      );
      dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          receiveTimeout: const Duration(seconds: 30),
        ),
      );
    });

    test('GET /v3/books/:isbn returns valid BookResult schema', () async {
      // Test with Harry Potter ISBN
      final response = await dio.get('/v3/books/9780439708180');

      expect(response.statusCode, 200);
      expect(response.data['success'], true);

      final data = response.data['data'] as Map<String, dynamic>;

      // Validate BookResult structure (work + edition + authors)
      expect(data.containsKey('work'), true);
      expect(data.containsKey('authors'), true);
      // edition may be null for some books

      // Validate Work fields
      final work = data['work'] as Map<String, dynamic>;
      expect(work['id'], isA<String>());
      expect(work['title'], isA<String>());

      // Validate Authors array
      final authors = data['authors'] as List;
      expect(authors, isA<List>());

      // Validate Edition if present
      if (data['edition'] != null) {
        final edition = data['edition'] as Map<String, dynamic>;
        expect(edition['id'], isA<String>());
        expect(edition['workId'], isA<String>());
      }
    });

    test('GET /v3/books/search returns valid SearchResponse schema', () async {
      final response = await dio.get(
        '/v3/books/search',
        queryParameters: {'q': 'harry potter', 'type': 'text', 'limit': 10},
      );

      expect(response.statusCode, 200);
      expect(response.data['success'], true);

      final data = response.data['data'] as Map<String, dynamic>;

      // Validate SearchResponse structure
      expect(data.containsKey('results'), true);
      expect(data['results'], isA<List>());
      expect(data['total'], isA<num>());
      expect(data['limit'], isA<num>());
      expect(data['offset'], isA<num>());

      // Validate first BookResult matches schema
      final results = data['results'] as List;
      if (results.isNotEmpty) {
        final firstResult = results[0] as Map<String, dynamic>;
        expect(firstResult.containsKey('work'), true);
        expect(firstResult.containsKey('authors'), true);

        final work = firstResult['work'] as Map<String, dynamic>;
        expect(work['id'], isA<String>());
        expect(work['title'], isA<String>());
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
      }
    });

    group('DTO Deserialization from Real API', () {
      test('BookResult → WorkDTO + EditionDTO + AuthorDTO mapping', () async {
        final response = await dio.get('/v3/books/9780439708180');
        final data = response.data['data'] as Map<String, dynamic>;

        // Validate WorkDTO deserialization
        final workJson = data['work'] as Map<String, dynamic>;
        final work = WorkDTO.fromJson(workJson);
        expect(work.id, isNotEmpty);
        expect(work.title, isNotEmpty);

        // Validate EditionDTO deserialization (if present)
        if (data['edition'] != null) {
          final editionJson = data['edition'] as Map<String, dynamic>;
          final edition = EditionDTO.fromJson(editionJson);
          expect(edition.id, isNotEmpty);
          expect(edition.workId, isNotEmpty);
        }

        // Validate AuthorDTO deserialization
        final authorsList = data['authors'] as List;
        for (final authorJson in authorsList) {
          final author = AuthorDTO.fromJson(authorJson as Map<String, dynamic>);
          expect(author.id, isNotEmpty);
          expect(author.name, isNotEmpty);
        }
      });
    });
  });
}
