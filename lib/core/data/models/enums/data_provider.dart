import 'package:freezed_annotation/freezed_annotation.dart';

enum DataProvider {
  @JsonValue('alexandria')
  alexandria,
  @JsonValue('google_books')
  googleBooks,
  @JsonValue('open_library')
  openLibrary,
  @JsonValue('isbndb')
  isbndb,
}
