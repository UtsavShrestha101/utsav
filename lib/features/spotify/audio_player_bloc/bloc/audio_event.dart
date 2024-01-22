import 'package:saro/core/models/spotify_playlist.dart';
import 'package:saro/core/models/spotify_searched_track.dart';

sealed class AudioEvent {}

final class AudioPlayEvent extends AudioEvent {
  SpotifyPlaylistItem? spotifyPlaylistItem;
  SpotifySearchedTrack? track;
  AudioPlayEvent({
    this.spotifyPlaylistItem,
    this.track,
  });
}

final class AudioPauseEvent extends AudioEvent {}

final class AudioResumeEvent extends AudioEvent {}

final class AudioStopEvent extends AudioEvent {}

final class FavoriteAudio extends AudioEvent {
  final SpotifySearchedTrack track;

  FavoriteAudio(this.track);
}
