import 'package:json_annotation/json_annotation.dart';

part 'spotify_playlist.g.dart';

@JsonSerializable(createToJson: false)
class SpotifyPlaylist {
    SpotifyPlaylist({
        required this.page,
        required this.limit,
        required this.total,
        required this.result,
    });

    final int? page;
    final int? limit;
    final int? total;
    final List<SpotifyPlaylistItem>? result;

    factory SpotifyPlaylist.fromJson(Map<String, dynamic> json) => _$SpotifyPlaylistFromJson(json);

}

@JsonSerializable(createToJson: false)
class SpotifyPlaylistItem {
    SpotifyPlaylistItem({
        required this.description,
        required this.id,
        required this.images,
        required this.name,
        required this.owner,
        required this.tracks,
        required this.uri,
    });

    final String? description;
    final String? id;
    final List<Image>? images;
    final String? name;
    final Owner? owner;
    final Tracks? tracks;
    final String? uri;

    factory SpotifyPlaylistItem.fromJson(Map<String, dynamic> json) => _$SpotifyPlaylistItemFromJson(json);

}

@JsonSerializable(createToJson: false)
class Image {
    Image({
        required this.height,
        required this.url,
        required this.width,
    });

    final dynamic height;
    final String? url;
    final dynamic width;

    factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

}

@JsonSerializable(createToJson: false)
class Owner {
    Owner({
        required this.displayName,
        required this.id,
        required this.uri,
    });

    @JsonKey(name: 'display_name') 
    final String? displayName;
    final String? id;
    final String? uri;

    factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

}

@JsonSerializable(createToJson: false)
class Tracks {
    Tracks({
        required this.total,
    });

    final int? total;

    factory Tracks.fromJson(Map<String, dynamic> json) => _$TracksFromJson(json);

}

