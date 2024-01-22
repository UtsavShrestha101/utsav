// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetail _$PostDetailFromJson(Map<String, dynamic> json) => PostDetail(
      id: json['id'] as String,
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
      visible: json['visible'] as bool?,
      filename: json['filename'] as String?,
      blurred: json['blurred'] == null
          ? null
          : BlurredData.fromJson(json['blurred'] as Map<String, dynamic>),
      filetype: $enumDecode(_$FileTypeEnumMap, json['filetype']),
      description: json['description'] as String?,
      isPremium: json['isPremium'] as bool,
      isLiked: json['isLiked'] as bool?,
      isDisliked: json['isDisliked'] as bool?,
      likes: json['likes'] as int?,
      dislikes: json['dislikes'] as int?,
      views: json['views'] as int?,
      userTagged: json['userTagged'] as List<dynamic>?,
      createdAt: json['createdAt'] as int,
      updatedAt: json['updatedAt'] as int,
      selfPost: json['selfPost'] as bool?,
      url: json['url'] as String?,
    )..placeholder = json['placeholder'] == null
        ? null
        : Placeholder.fromJson(json['placeholder'] as Map<String, dynamic>);

Map<String, dynamic> _$PostDetailToJson(PostDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visible': instance.visible,
      'filetype': _$FileTypeEnumMap[instance.filetype]!,
      'filename': instance.filename,
      'placeholder': instance.placeholder,
      'blurred': instance.blurred,
      'user': instance.user,
      'url': instance.url,
      'description': instance.description,
      'isPremium': instance.isPremium,
      'isLiked': instance.isLiked,
      'isDisliked': instance.isDisliked,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'views': instance.views,
      'userTagged': instance.userTagged,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'selfPost': instance.selfPost,
    };

const _$FileTypeEnumMap = {
  FileType.image: 'IMAGE',
  FileType.video: 'VIDEO',
};

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] as String,
      username: json['username'] as String,
      isIdentityVerified: json['isIdentityVerified'] as bool,
      premiumCharge: json['premiumCharge'],
      avatar: json['avatar'] as String?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
      'isIdentityVerified': instance.isIdentityVerified,
      'premiumCharge': instance.premiumCharge,
      'count': instance.count,
    };

BlurredData _$BlurredDataFromJson(Map<String, dynamic> json) => BlurredData(
      filename: json['filename'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$BlurredDataToJson(BlurredData instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'url': instance.url,
    };

Placeholder _$PlaceholderFromJson(Map<String, dynamic> json) => Placeholder(
      json['filename'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$PlaceholderToJson(Placeholder instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'url': instance.url,
    };
