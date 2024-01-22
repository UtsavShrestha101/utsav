// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'spotify_searched_track.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpotifySearchedTrackAdapter extends TypeAdapter<SpotifySearchedTrack> {
  @override
  final int typeId = 5;

  @override
  SpotifySearchedTrack read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpotifySearchedTrack(
      id: fields[0] as String?,
      name: fields[1] as String?,
      durationMs: fields[3] as int?,
      popularity: fields[4] as int?,
      previewUrl: fields[5] as String?,
      uri: fields[6] as String?,
      artists: (fields[7] as List?)?.cast<Artist>(),
    );
  }

  @override
  void write(BinaryWriter writer, SpotifySearchedTrack obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.durationMs)
      ..writeByte(4)
      ..write(obj.popularity)
      ..writeByte(5)
      ..write(obj.previewUrl)
      ..writeByte(6)
      ..write(obj.uri)
      ..writeByte(7)
      ..write(obj.artists);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpotifySearchedTrackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ArtistAdapter extends TypeAdapter<Artist> {
  @override
  final int typeId = 6;

  @override
  Artist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Artist(
      id: fields[0] as String?,
      name: fields[1] as String?,
      uri: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Artist obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.uri);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotifySearchedTrackModel _$SpotifySearchedTrackModelFromJson(
        Map<String, dynamic> json) =>
    SpotifySearchedTrackModel(
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      total: json['total'] as int?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => SpotifySearchedTrack.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

SpotifySearchedTrack _$SpotifySearchedTrackFromJson(
        Map<String, dynamic> json) =>
    SpotifySearchedTrack(
      id: json['id'] as String?,
      name: json['name'] as String?,
      durationMs: json['duration_ms'] as int?,
      popularity: json['popularity'] as int?,
      previewUrl: json['preview_url'] as String?,
      uri: json['uri'] as String?,
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpotifySearchedTrackToJson(
        SpotifySearchedTrack instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'duration_ms': instance.durationMs,
      'popularity': instance.popularity,
      'preview_url': instance.previewUrl,
      'uri': instance.uri,
      'artists': instance.artists,
    };

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
      id: json['id'] as String?,
      name: json['name'] as String?,
      uri: json['uri'] as String?,
    );

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'uri': instance.uri,
    };
