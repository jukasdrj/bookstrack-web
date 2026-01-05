import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_library_entry_fs.freezed.dart';
part 'user_library_entry_fs.g.dart';

/// Firestore model for user library entries
/// Stored at: users/{userId}/library/{workId}
@freezed
class UserLibraryEntryFS with _$UserLibraryEntryFS {
  const factory UserLibraryEntryFS({
    required String workId,
    required String title,
    required String author,
    required String status, // wishlist|toRead|reading|read
    int? currentPage,
    int? personalRating, // 1-5
    String? notes,
    @JsonKey(name: 'startedAt')
    @TimestampConverter()
    DateTime? startedAt,
    @JsonKey(name: 'finishedAt')
    @TimestampConverter()
    DateTime? finishedAt,
    @JsonKey(name: 'createdAt')
    @TimestampConverter()
    required DateTime createdAt,
    @JsonKey(name: 'updatedAt')
    @TimestampConverter()
    required DateTime updatedAt,
  }) = _UserLibraryEntryFS;

  factory UserLibraryEntryFS.fromJson(Map<String, dynamic> json) =>
      _$UserLibraryEntryFSFromJson(json);
}

/// Firestore Timestamp converter for Freezed
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
