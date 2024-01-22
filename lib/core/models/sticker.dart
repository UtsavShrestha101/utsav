import 'package:json_annotation/json_annotation.dart';

part 'sticker.g.dart';

@JsonSerializable()
class Sticker {
  String id;
  String name;
  String url;
  String filename;
  int createdAt;
  int updatedAt;

  Sticker({
    required this.id,
    required this.name,
    required this.url,
    required this.filename,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sticker.fromJson(Map<String, dynamic> json) =>
      _$StickerFromJson(json);

  Map<String, dynamic> toJson() => _$StickerToJson(this);
}
