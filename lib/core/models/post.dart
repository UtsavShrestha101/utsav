import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';


@JsonSerializable()

class Post{
  final String id;
  final PostOwner user;
  final bool viewed;

  Post(this.id, this.user, this.viewed);
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> get toJson => _$PostToJson(this);
}

@JsonSerializable()
class PostOwner {
  final String id;
  final String username;
  final String? avatar;
  PostOwner({
    required this.id,
    required this.username,
    this.avatar,
  });

  factory PostOwner.fromJson(Map<String, dynamic> json) => _$PostOwnerFromJson(json);

  Map<String, dynamic> get toJson => _$PostOwnerToJson(this);
}
