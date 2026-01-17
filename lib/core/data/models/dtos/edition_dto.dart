import 'package:freezed_annotation/freezed_annotation.dart';

part 'edition_dto.freezed.dart';
part 'edition_dto.g.dart';

@freezed
sealed class EditionDTO with _$EditionDTO {
  const factory EditionDTO({
    required String id,
    required String workId,
    String? isbn,
    String? isbn10,
    String? isbn13,
    String? subtitle,
    String? publisher,
    int? publishedYear,
    String? coverImageURL,
    @JsonKey(name: 'thumbnailUrl') String? thumbnailURL,
    String? description,
    String? format,
    int? pageCount,
    String? language,
    String? editionKey,
    @Default([]) List<String> categories,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _EditionDTO;

  factory EditionDTO.fromJson(Map<String, dynamic> json) =>
      _$EditionDTOFromJson(json);
}
