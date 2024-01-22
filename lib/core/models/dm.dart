// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
import 'package:saro/core/models/post_detail.dart';


part 'dm.g.dart';

@JsonSerializable()
class Dm {
  String id;
  int? index;
  String userId;
  String roomId;
  String? mediaGroupId;
  String? text;
  String? sourceImg;
  bool link;
  double? gift;
  DMType type;
  List<DmMedia>? medias;
  PostDetail? post;
  int createdAt;
  int updatedAt;
  UserData? user;
  Dm({
    required this.id,
    required this.userId,
    required this.roomId,
    this.index,
    this.mediaGroupId,
    this.text,
    this.sourceImg,
    required this.link,
    this.gift,
    required this.type,
    this.medias,
    this.post,
    this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Dm.fromJson(Map<String, dynamic> json) => _$DmFromJson(json);

  Map<String, dynamic> toJson() => _$DmToJson(this);

  bool isByUser(String userId) => userId == this.userId;

  Dm copyWith({
    int? index,
  }) {
    return Dm(
      id: id,
      index: index ?? this.index,
      userId: userId,
      roomId: roomId,
      mediaGroupId: mediaGroupId,
      text: text,
      sourceImg: sourceImg,
      link: link,
      gift: gift,
      type: type,
      medias: medias,
      post: post,
      createdAt: createdAt,
      updatedAt: updatedAt,
      user: user,
    );
  }
}



enum DMType {
  @JsonValue("TEXT")
  TEXT,
  @JsonValue("SOURCE_IMG")
  SOURCE_IMG,
  @JsonValue("MEDIAS")
  MEDIAS,
  @JsonValue("REPLY_POST")
  REPLY_POST,
  @JsonValue("REPLY_DM")
  REPLY_DM,
  @JsonValue("GIFT")
  GIFT,
  @JsonValue("FORWARD_USER")
  FORWARD_USER,
  @JsonValue("FORWARD_POST")
  FORWARD_POST
}

enum FileType {
  @JsonValue('IMAGE')
  image,

  @JsonValue('VIDEO')
  video
}

@JsonSerializable()
class DmMedia {
  String id;
  String roomId;
  String filename;
  String url;
  FileType filetype;
  int createdAt;
  int updatedAt;
  Placeholder? placeholder;
  DmMediaDuration? duration;

  DmMedia({
    required this.id,
    required this.roomId,
    required this.filename,
    required this.filetype,
    required this.createdAt,
    required this.updatedAt,
    this.placeholder,
    this.duration,
    required this.url,
  });

  factory DmMedia.fromJson(Map<String, dynamic> json) =>
      _$DmMediaFromJson(json);

  Map<String, dynamic> toJson() => _$DmMediaToJson(this);
}

@JsonSerializable()
class DmMediaDuration {
  double? inMs;
  String? inText;

  DmMediaDuration({
    this.inMs,
    this.inText,
  });

  factory DmMediaDuration.fromJson(Map<String, dynamic> json) =>
      _$DmMediaDurationFromJson(json);

  Map<String, dynamic> toJson() => _$DmMediaDurationToJson(this);
}
