// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSearchResult _$UserSearchResultFromJson(Map<String, dynamic> json) =>
    UserSearchResult(
      json['id'] as String,
      json['isIdentityVerified'] as bool,
      json['username'] as String,
      json['isFollowing'] as bool,
      json['avatar'] as String?,
    );

Map<String, dynamic> _$UserSearchResultToJson(UserSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'isFollowing': instance.isFollowing,
      'isIdentityVerified': instance.isIdentityVerified,
      'avatar': instance.avatar,
    };
