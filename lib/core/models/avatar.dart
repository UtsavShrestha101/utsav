import 'package:json_annotation/json_annotation.dart';
part 'avatar.g.dart';

@JsonSerializable()
class Avatar {
  final String id;
  final String name;
  final String url;
  final int createdAt;
  final int updatedAt;

  Avatar(
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.url,
  );

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);

  Map<String, dynamic> get toJson => _$AvatarToJson(this);
}
