import 'package:saro/core/models/spotify_detail.dart';

enum SpotifyLoginStatus { initial, loading, success, failure }
enum SpotifyDetailStatus {initial,loading,success,failure}

class SpotifyAuthState {
  final bool isUserAuthenticated;
  final String? failureMsg;
  final SpotifyLoginStatus spotifyLoginStatus;
  final SpotifyDetail? spotifyDetail;
  final SpotifyDetailStatus? spotifyDetailStatus;

  const SpotifyAuthState(this.isUserAuthenticated,
      {this.failureMsg="",
      this.spotifyLoginStatus = SpotifyLoginStatus.initial,
      this.spotifyDetail,
      this.spotifyDetailStatus=SpotifyDetailStatus.initial});

  SpotifyAuthState copyWith(
      {bool? isUserAuthenticated,
      String? failureMsg,
      SpotifyLoginStatus? spotifyLoginStatus,
      SpotifyDetail? spotifyDetail,
      SpotifyDetailStatus? spotifyDetailStatus}) {
    return SpotifyAuthState(isUserAuthenticated ?? this.isUserAuthenticated,
        failureMsg: failureMsg ?? this.failureMsg,
        spotifyLoginStatus: spotifyLoginStatus ?? this.spotifyLoginStatus,
        spotifyDetail: spotifyDetail ?? this.spotifyDetail,
        spotifyDetailStatus: spotifyDetailStatus ?? this.spotifyDetailStatus);
  }
}
