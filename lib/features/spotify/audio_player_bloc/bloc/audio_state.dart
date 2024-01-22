import 'package:saro/core/models/spotify_playlist.dart';
import 'package:saro/core/models/spotify_searched_track.dart';

enum AudioPlayerStatus { initial, playing, paused, stopped }

final class AudioState {
  const AudioState({
    this.status = AudioPlayerStatus.initial,
    this.failureMsg = "",
    this.spotifyPlaylistItem,
    this.track,
    this.isAudioFromPlaylist = true,
    this.userProfileTrack,
  });

  final AudioPlayerStatus status;
  final String failureMsg;
  final SpotifyPlaylistItem? spotifyPlaylistItem;
  final SpotifySearchedTrack? track;
  final SpotifySearchedTrack? userProfileTrack;
  final bool isAudioFromPlaylist;

  AudioState copyWith({
    AudioPlayerStatus? status,
    String? failureMsg,
    SpotifyPlaylistItem? spotifyPlaylistItem,
    bool? isAudioFromPlaylist,
    SpotifySearchedTrack? track,
    SpotifySearchedTrack? userProfileTrack,
  }) {
    return AudioState(
      status: status ?? this.status,
      failureMsg: failureMsg ?? this.failureMsg,
      spotifyPlaylistItem: spotifyPlaylistItem ?? this.spotifyPlaylistItem,
      track: track ?? this.track,
      isAudioFromPlaylist: isAudioFromPlaylist ?? this.isAudioFromPlaylist,
      userProfileTrack: userProfileTrack ?? this.userProfileTrack,
    );
  }
}
