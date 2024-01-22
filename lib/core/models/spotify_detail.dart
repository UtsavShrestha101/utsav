import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'spotify_detail.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 8)
class SpotifyDetail {
  SpotifyDetail({
    required this.displayName,
    required this.id,
    required this.images,
    required this.uri,
    required this.followers,
    required this.country,
    required this.email,
  });

  @JsonKey(name: 'display_name')
  @HiveField(0)
  final String? displayName;
  @HiveField(1)
  final String? id;
  @HiveField(2)
  final List<Image>? images;
  @HiveField(3)
  final String? uri;
  @HiveField(4)
  final Followers? followers;
  @HiveField(5)
  final String? country;
  @HiveField(6)
  final String? email;

  factory SpotifyDetail.fromJson(Map<String, dynamic> json) =>
      _$SpotifyDetailFromJson(json);
}

@JsonSerializable(createToJson: false)
@HiveType(typeId: 9)
class Followers {
  Followers({
    required this.total,
  });
  @HiveField(0)
  final int? total;

  factory Followers.fromJson(Map<String, dynamic> json) =>
      _$FollowersFromJson(json);
}

@JsonSerializable(createToJson: false)
@HiveType(typeId: 10)
class Image {
  Image({
    required this.url,
    required this.height,
    required this.width,
  });
  @HiveField(0)
  final String? url;
  @HiveField(1)
  final int? height;
  @HiveField(2)
  final int? width;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}
