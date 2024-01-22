// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user_search_result.g.dart';

@JsonSerializable()
class UserSearchResult {
  final String id;
  final String username;
  final bool isFollowing;
  final bool isIdentityVerified;
  final String? avatar;

  UserSearchResult(this.id,this.isIdentityVerified, this.username, this.isFollowing, this.avatar);

  factory UserSearchResult.fromJson(Map<String, dynamic> json) =>
      _$UserSearchResultFromJson(json);
  Map<String, dynamic> get toJson => _$UserSearchResultToJson(this);

  UserSearchResult copyWith({
    String? id,
    String? username,
    bool? isFollowing,
    String? avatar,
  }) {
    return UserSearchResult(
      id ?? this.id,
      isIdentityVerified,
      username ?? this.username,
      isFollowing ?? this.isFollowing,
      avatar ?? this.avatar,
    );
  }
}
