// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dm _$DmFromJson(Map<String, dynamic> json) => Dm(
      id: json['id'] as String,
      userId: json['userId'] as String,
      roomId: json['roomId'] as String,
      index: json['index'] as int?,
      mediaGroupId: json['mediaGroupId'] as String?,
      text: json['text'] as String?,
      sourceImg: json['sourceImg'] as String?,
      link: json['link'] as bool,
      gift: (json['gift'] as num?)?.toDouble(),
      type: $enumDecode(_$DMTypeEnumMap, json['type']),
      medias: (json['medias'] as List<dynamic>?)
          ?.map((e) => DmMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
      post: json['post'] == null
          ? null
          : PostDetail.fromJson(json['post'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as int,
      updatedAt: json['updatedAt'] as int,
    );

Map<String, dynamic> _$DmToJson(Dm instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'userId': instance.userId,
      'roomId': instance.roomId,
      'mediaGroupId': instance.mediaGroupId,
      'text': instance.text,
      'sourceImg': instance.sourceImg,
      'link': instance.link,
      'gift': instance.gift,
      'type': _$DMTypeEnumMap[instance.type]!,
      'medias': instance.medias,
      'post': instance.post,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'user': instance.user,
    };

const _$DMTypeEnumMap = {
  DMType.TEXT: 'TEXT',
  DMType.SOURCE_IMG: 'SOURCE_IMG',
  DMType.MEDIAS: 'MEDIAS',
  DMType.REPLY_POST: 'REPLY_POST',
  DMType.REPLY_DM: 'REPLY_DM',
  DMType.GIFT: 'GIFT',
  DMType.FORWARD_USER: 'FORWARD_USER',
  DMType.FORWARD_POST: 'FORWARD_POST',
};

DmMedia _$DmMediaFromJson(Map<String, dynamic> json) => DmMedia(
      id: json['id'] as String,
      roomId: json['roomId'] as String,
      filename: json['filename'] as String,
      filetype: $enumDecode(_$FileTypeEnumMap, json['filetype']),
      createdAt: json['createdAt'] as int,
      updatedAt: json['updatedAt'] as int,
      placeholder: json['placeholder'] == null
          ? null
          : Placeholder.fromJson(json['placeholder'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? null
          : DmMediaDuration.fromJson(json['duration'] as Map<String, dynamic>),
      url: json['url'] as String,
    );

Map<String, dynamic> _$DmMediaToJson(DmMedia instance) => <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'filename': instance.filename,
      'url': instance.url,
      'filetype': _$FileTypeEnumMap[instance.filetype]!,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'placeholder': instance.placeholder,
      'duration': instance.duration,
    };

const _$FileTypeEnumMap = {
  FileType.image: 'IMAGE',
  FileType.video: 'VIDEO',
};

DmMediaDuration _$DmMediaDurationFromJson(Map<String, dynamic> json) =>
    DmMediaDuration(
      inMs: (json['inMs'] as num?)?.toDouble(),
      inText: json['inText'] as String?,
    );

Map<String, dynamic> _$DmMediaDurationToJson(DmMediaDuration instance) =>
    <String, dynamic>{
      'inMs': instance.inMs,
      'inText': instance.inText,
    };
