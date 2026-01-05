import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_library_entry_fs.dart';

part 'user_profile_fs.freezed.dart';
part 'user_profile_fs.g.dart';

/// Firestore model for user profile
/// Stored at: users/{userId}/profile
@freezed
class UserProfileFS with _$UserProfileFS {
  const factory UserProfileFS({
    required String email,
    String? displayName,
    String? photoURL,
    @JsonKey(name: 'createdAt')
    @TimestampConverter()
    required DateTime createdAt,
    @JsonKey(name: 'lastSyncAt')
    @TimestampConverter()
    DateTime? lastSyncAt,
  }) = _UserProfileFS;

  factory UserProfileFS.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFSFromJson(json);
}
