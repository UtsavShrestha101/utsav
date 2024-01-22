// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      json['id'] as String,
      PostOwner.fromJson(json['user'] as Map<String, dynamic>),
      json['viewed'] as bool,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'viewed': instance.viewed,
    };

PostOwner _$PostOwnerFromJson(Map<String, dynamic> json) => PostOwner(
      id: json['id'] as String,
      username: json['username'] as String,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$PostOwnerToJson(PostOwner instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
    };
