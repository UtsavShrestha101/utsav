import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'spotify_searched_track.g.dart';

@JsonSerializable(createToJson: false)
class SpotifySearchedTrackModel {
  SpotifySearchedTrackModel({
    this.page,
    this.limit,
    this.total,
    this.result,
  });

  final int? page;
  final int? limit;
  final int? total;
  final List<SpotifySearchedTrack>? result;

  factory SpotifySearchedTrackModel.fromJson(Map<String, dynamic> json) =>
      _$SpotifySearchedTrackModelFromJson(json);
}

@JsonSerializable(createToJson: true)
@HiveType(typeId: 5)
class SpotifySearchedTrack {
  SpotifySearchedTrack({
    this.id,
    this.name,
    this.durationMs,
    this.popularity,
    this.previewUrl,
    this.uri,
    this.artists,
  });
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? name;

  @JsonKey(name: 'duration_ms')
  @HiveField(3)
  final int? durationMs;
  @HiveField(4)
  final int? popularity;

  @JsonKey(name: 'preview_url')
  @HiveField(5)
  final String? previewUrl;
  @HiveField(6)
  final String? uri;
  @HiveField(7)
  final List<Artist>? artists;

  factory SpotifySearchedTrack.fromJson(Map<String, dynamic> json) =>
      _$SpotifySearchedTrackFromJson(json);
}

@HiveType(typeId: 6)
@JsonSerializable(createToJson: true)
class Artist {
  Artist({
    this.id,
    this.name,
    this.uri,
  });
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? uri;

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
}
