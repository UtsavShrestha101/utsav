// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      json['id'] as String,
      json['name'] as String?,
      json['isGroup'] as bool,
      (json['members'] as List<dynamic>)
          .map((e) => RoomUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      Dm.fromJson(json['latestMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isGroup': instance.isGroup,
      'members': instance.members,
      'latestMessage': instance.latestMessage,
    };

RoomUser _$RoomUserFromJson(Map<String, dynamic> json) => RoomUser(
      json['id'] as String,
      json['unread'] as int?,
      json['createdAt'] as int,
      UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoomUserToJson(RoomUser instance) => <String, dynamic>{
      'id': instance.id,
      'unread': instance.unread,
      'createdAt': instance.createdAt,
      'user': instance.user,
    };
