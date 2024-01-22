// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotify_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpotifyDetailAdapter extends TypeAdapter<SpotifyDetail> {
  @override
  final int typeId = 8;

  @override
  SpotifyDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpotifyDetail(
      displayName: fields[0] as String?,
      id: fields[1] as String?,
      images: (fields[2] as List?)?.cast<Image>(),
      uri: fields[3] as String?,
      followers: fields[4] as Followers?,
      country: fields[5] as String?,
      email: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SpotifyDetail obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.images)
      ..writeByte(3)
      ..write(obj.uri)
      ..writeByte(4)
      ..write(obj.followers)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(6)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpotifyDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FollowersAdapter extends TypeAdapter<Followers> {
  @override
  final int typeId = 9;

  @override
  Followers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Followers(
      total: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Followers obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FollowersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ImageAdapter extends TypeAdapter<Image> {
  @override
  final int typeId = 10;

  @override
  Image read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Image(
      url: fields[0] as String?,
      height: fields[1] as int?,
      width: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Image obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.width);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotifyDetail _$SpotifyDetailFromJson(Map<String, dynamic> json) =>
    SpotifyDetail(
      displayName: json['display_name'] as String?,
      id: json['id'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      uri: json['uri'] as String?,
      followers: json['followers'] == null
          ? null
          : Followers.fromJson(json['followers'] as Map<String, dynamic>),
      country: json['country'] as String?,
      email: json['email'] as String?,
    );

Followers _$FollowersFromJson(Map<String, dynamic> json) => Followers(
      total: json['total'] as int?,
    );

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      url: json['url'] as String?,
      height: json['height'] as int?,
      width: json['width'] as int?,
    );
