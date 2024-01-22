// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:saro/core/models/dm.dart';
part 'post_detail.g.dart';

@JsonSerializable()
class PostDetail {
  String id;
  bool? visible;
  FileType filetype;
  String? filename;
  Placeholder? placeholder;
  BlurredData? blurred;
  UserData? user;
  String? url;
  String? description;
  bool isPremium;
  bool? isLiked;
  bool? isDisliked;
  int? likes;
  int? dislikes;
  int? views;
  List? userTagged;
  int createdAt;
  int updatedAt;
  bool? selfPost;

  PostDetail({
    required this.id,
    required this.user,
    required this.visible,
    this.filename,
    this.blurred,
    required this.filetype,
    this.description,
    required this.isPremium,
    required this.isLiked,
    required this.isDisliked,
    required this.likes,
    required this.dislikes,
    required this.views,
    required this.userTagged,
    required this.createdAt,
    required this.updatedAt,
    this.selfPost,
    this.url,
  });

  factory PostDetail.fromJson(Map<String, dynamic> json) =>
      _$PostDetailFromJson(json);

  Map<String, dynamic> get toJson => _$PostDetailToJson(this);

  PostDetail copyWith({
    String? id,
    UserData? user,
    bool? visible,
    String? filename,
    FileType? filetype,
    String? description,
    bool? isPremium,
    bool? isLiked,
    bool? isDisliked,
    int? likes,
    int? dislikes,
    int? views,
    List? userTagged,
    int? createdAt,
    int? updatedAt,
    bool? selfPost,
  }) {
    return PostDetail(
        id: id ?? this.id,
        user: user ?? this.user,
        visible: visible ?? this.visible,
        filename: filename ?? this.filename,
        filetype: filetype ?? this.filetype,
        description: description ?? this.description,
        isPremium: isPremium ?? this.isPremium,
        isLiked: isLiked ?? this.isLiked,
        isDisliked: isDisliked ?? this.isDisliked,
        likes: likes ?? this.likes,
        dislikes: dislikes ?? this.dislikes,
        views: views ?? this.views,
        userTagged: userTagged ?? this.userTagged,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        selfPost: selfPost ?? this.selfPost);
  }
}

@JsonSerializable()
class UserData {
  String id;
  String username;
  String? avatar;
  bool isIdentityVerified;
  dynamic premiumCharge;
  int? count;
  UserData({
    required this.id,
    required this.username,
    required this.isIdentityVerified,
    required this.premiumCharge,
    this.avatar,
    this.count,
  });
  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> get toJson => _$UserDataToJson(this);
}

@JsonSerializable()
class BlurredData {
  String filename;
  String url;

  BlurredData({
    required this.filename,
    required this.url,
  });
  factory BlurredData.fromJson(Map<String, dynamic> json) =>
      _$BlurredDataFromJson(json);

  Map<String, dynamic> get toJson => _$BlurredDataToJson(this);
}

@JsonSerializable()
class Placeholder {
  final String filename;
  final String url;

  Placeholder(this.filename, this.url);

  factory Placeholder.fromJson(Map<String, dynamic> json) =>
      _$PlaceholderFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceholderToJson(this);
}
