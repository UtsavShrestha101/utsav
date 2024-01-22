import 'package:saro/core/models/spotify_playlist.dart';

final class SpotifyPlaylistState {
  const SpotifyPlaylistState({
    this.spotifyPlaylist = const <SpotifyPlaylistItem>[],
    this.hasReachedMax = false,
    this.failureMsg,
    this.page = 1,
    this.isLoading = false,
  });

  final List<SpotifyPlaylistItem> spotifyPlaylist;
  final bool isLoading;
  final int page;
  final String? failureMsg;
  final bool hasReachedMax;

  SpotifyPlaylistState copyWith({
    List<SpotifyPlaylistItem>? spotifyPlaylist,
    bool? hasReachedMax,
    String? failureMsg,
    bool? isLoading,
    int? page,
  }) {
    return SpotifyPlaylistState(
      spotifyPlaylist: spotifyPlaylist ?? this.spotifyPlaylist,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      failureMsg: failureMsg ?? this.failureMsg,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
    );
  }

  bool get isListEmpty => spotifyPlaylist.isEmpty && !isLoading;
}
