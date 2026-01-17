import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_library_entry_fs.dart';

part 'edition_fs.freezed.dart';
part 'edition_fs.g.dart';

/// Firestore model for book editions
/// Stored at: users/{userId}/editions/{editionId}
@freezed
sealed class EditionFS with _$EditionFS {
  const factory EditionFS({
    required String id,
    required String workId,
    String? isbn,
    String? isbn10,
    String? isbn13,
    String? publisher,
    int? publishedYear,
    String? coverImageURL,
    String? thumbnailURL,
    int? pageCount,
    String? language,
    @JsonKey(name: 'createdAt')
    @TimestampConverter()
    required DateTime createdAt,
    @JsonKey(name: 'updatedAt')
    @TimestampConverter()
    required DateTime updatedAt,
  }) = _EditionFS;

  factory EditionFS.fromJson(Map<String, dynamic> json) =>
      _$EditionFSFromJson(json);
}
