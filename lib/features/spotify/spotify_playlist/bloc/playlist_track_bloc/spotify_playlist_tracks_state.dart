import 'package:saro/core/models/spotify_searched_track.dart';

final class SpotifyPlaylistTrackState {
  const SpotifyPlaylistTrackState({
    this.spotifyPlaylistTracks = const <SpotifySearchedTrack>[],
    this.hasReachedMax = false,
    this.failureMsg,
    this.page = 1,
    this.isLoading = false,
  });

  final List<SpotifySearchedTrack> spotifyPlaylistTracks;
  final bool isLoading;
  final int page;
  final String? failureMsg;
  final bool hasReachedMax;

  SpotifyPlaylistTrackState copyWith({
    List<SpotifySearchedTrack>? spotifyPlaylistTracks,
    bool? hasReachedMax,
    String? failureMsg,
    bool? isLoading,
    int? page,
  }) {
    return SpotifyPlaylistTrackState(
      spotifyPlaylistTracks: spotifyPlaylistTracks ?? this.spotifyPlaylistTracks,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      failureMsg: failureMsg ?? this.failureMsg,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
    );
  }

  bool get isListEmpty => spotifyPlaylistTracks.isEmpty && !isLoading;
}
