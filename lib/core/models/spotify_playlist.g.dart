// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotify_playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotifyPlaylist _$SpotifyPlaylistFromJson(Map<String, dynamic> json) =>
    SpotifyPlaylist(
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      total: json['total'] as int?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => SpotifyPlaylistItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

SpotifyPlaylistItem _$SpotifyPlaylistItemFromJson(Map<String, dynamic> json) =>
    SpotifyPlaylistItem(
      description: json['description'] as String?,
      id: json['id'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      owner: json['owner'] == null
          ? null
          : Owner.fromJson(json['owner'] as Map<String, dynamic>),
      tracks: json['tracks'] == null
          ? null
          : Tracks.fromJson(json['tracks'] as Map<String, dynamic>),
      uri: json['uri'] as String?,
    );

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      height: json['height'],
      url: json['url'] as String?,
      width: json['width'],
    );

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      displayName: json['display_name'] as String?,
      id: json['id'] as String?,
      uri: json['uri'] as String?,
    );

Tracks _$TracksFromJson(Map<String, dynamic> json) => Tracks(
      total: json['total'] as int?,
    );
