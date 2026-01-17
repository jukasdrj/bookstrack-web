import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/data_provider.dart';

part 'work_dto.freezed.dart';
part 'work_dto.g.dart';

@freezed
sealed class WorkDTO with _$WorkDTO {
  const factory WorkDTO({
    required String id,
    required String title,
    String? subtitle,
    String? description,
    String? author, // Denormalized author field
    @Default([]) List<String> authorIds,
    @Default([]) List<String> subjectTags,
    @Default(false) bool synthetic,
    String? reviewStatus,
    String? workKey,
    DataProvider? provider,
    @JsonKey(name: 'quality') int? qualityScore,
    @Default([]) List<String> categories,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WorkDTO;

  factory WorkDTO.fromJson(Map<String, dynamic> json) =>
      _$WorkDTOFromJson(json);
}
