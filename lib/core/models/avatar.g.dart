// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Avatar _$AvatarFromJson(Map<String, dynamic> json) => Avatar(
      json['id'] as String,
      json['name'] as String,
      json['createdAt'] as int,
      json['updatedAt'] as int,
      json['url'] as String,
    );

Map<String, dynamic> _$AvatarToJson(Avatar instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
