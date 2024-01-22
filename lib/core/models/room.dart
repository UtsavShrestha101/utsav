import 'package:json_annotation/json_annotation.dart';
import 'package:saro/core/models/dm.dart';
import 'package:saro/core/models/post_detail.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  final String id;
  final String? name;
  final bool isGroup;
  final List<RoomUser> members;
  final Dm latestMessage;

  Room(
    this.id,
    this.name,
    this.isGroup,
    this.members,
    this.latestMessage,
  );
  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> get toJson => _$RoomToJson(this);
}

@JsonSerializable()
class RoomUser {
  final String id;
  int? unread;
  final int createdAt;
  final UserData user;

  RoomUser(
    this.id,
    this.unread,
    this.createdAt,
    this.user,
  );

  factory RoomUser.fromJson(Map<String, dynamic> json) =>
      _$RoomUserFromJson(json);
}
