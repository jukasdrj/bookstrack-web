import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api/search_service.dart';

/// Provider for the API client
final apiClientProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = 'https://api.oooefam.net';
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 60);
  return dio;
});

/// Provider for the search service
final searchServiceProvider = Provider<SearchService>((ref) {
  final dio = ref.watch(apiClientProvider);
  return SearchService(dio);
});
