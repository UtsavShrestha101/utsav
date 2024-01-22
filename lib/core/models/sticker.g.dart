// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sticker _$StickerFromJson(Map<String, dynamic> json) => Sticker(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      filename: json['filename'] as String,
      createdAt: json['createdAt'] as int,
      updatedAt: json['updatedAt'] as int,
    );

Map<String, dynamic> _$StickerToJson(Sticker instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'filename': instance.filename,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
