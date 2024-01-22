// ignore_for_file: unused_field

import 'package:injectable/injectable.dart';
import 'package:saro/core/base/base_repository.dart';
import 'package:saro/core/models/spotify_detail.dart';
import 'package:saro/core/models/spotify_playlist.dart';
import 'package:saro/core/models/spotify_searched_track.dart';
import 'package:saro/core/models/user.dart';
import 'package:saro/core/repository/user_repository.dart';

@lazySingleton
class SpotifyRepository extends BaseRepository {
  SpotifyRepository(super.dio, super.database, this._userRepository);
  final UserRepository _userRepository;

  @override
  User? get currentUser => database.currentUser;

  static const _baseUrl = "https://api-dev.saro.love/v1";
  static String _logInPath(String userId) =>
      "$_baseUrl/spotify/login?uri=https://dev.saro.love/profile&userId=$userId";
  static const _playlistPath = '/spotify/my-playlists';
  static const _searchPath = '/spotify/search-tracks';
  static const _logOutPath = '/spotify/logout';
  static _playListTrackPath(String playListId) =>
      '/spotify/my-playlists/$playListId/tracks';
  static const _getMyDetailPath = '/spotify/me';
  static _favoriteTrack(String playListId) =>
      '/spotify/profile-track/$playListId';

//login
  Future<bool> checkLogInSuccess() async {
    bool isLoginSuccess = false;

    User user = await _userRepository.refreshCurrentUser();
    if (user.isSpotifyConnected ?? false) {
      isLoginSuccess = true;
    } else {
      isLoginSuccess = false;
    }

    return isLoginSuccess;
  }

  Future<bool> isUserConnectedToSpotify() async {
    final isUserConnected = database.currentUser?.isSpotifyConnected ?? false;
    if (isUserConnected) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<SpotifyPlaylistItem>> getSpotifyPlaylist(
    int page,
  ) async {
    final params = {
      "page": page,
      "limit": 10,
    };
    return makeDioRequest<List<SpotifyPlaylistItem>>(() async {
      final response = await dio.get(
        _playlistPath,
        queryParameters: params,
      );
      return (response.data['result'] as List)
          .map((e) => SpotifyPlaylistItem.fromJson(e))
          .toList();
    });
  }

  Future<List<SpotifySearchedTrack>> getSpotifyPlaylistTrack(
    String playListId, {
    int? page = 1,
    int? limit = 10,
  }) async {
    final params = {
      "page": page,
      "limit": limit,
    };
    return makeDioRequest<List<SpotifySearchedTrack>>(() async {
      final response = await dio.get(_playListTrackPath(playListId),
          queryParameters: params);
      return (response.data['result'] as List)
          .map((e) => SpotifySearchedTrack.fromJson(e["track"]))
          .toList();
    });
  }

  Future<List<SpotifySearchedTrack>> searchTrack(
      {int? page = 1, int? limit = 10, String? query}) async {
    final params = {"page": page, "limit": limit, "q": query};
    return makeDioRequest<List<SpotifySearchedTrack>>(() async {
      final response = await dio.get(_searchPath, queryParameters: params);
      return (response.data['result'] as List)
          .map((e) => SpotifySearchedTrack.fromJson(e))
          .toList();
    });
  }

  Future<SpotifyDetail> getSpotifyDetail() async {
    SpotifyDetail? spotifyDetail = database.spotifyDetail;
    if (spotifyDetail == null) {
      final SpotifyDetail detail =
          await makeDioRequest<SpotifyDetail>(() async {
        final response = await dio.get(_getMyDetailPath);
        return SpotifyDetail.fromJson(response.data);
      });
      database.setSpotifyDetail(detail);
      return detail;
    } else {
      return spotifyDetail;
    }
  }

  Future<void> logout() async {
    makeDioRequest<void>(() async {
      await dio.delete(_logOutPath);
    });
    database.clearSpotifyData();
  }

  // get spotify login full Url
  String getSpotifyLoginUrl() {
    String id = currentUser!.id;

    return _logInPath(id);
  }

  String getAuthToken() {
    return database.credentials?.bearerAccessToken ?? "";
  }

  User? getCurrentUser() {
    return database.currentUser!;
  }

  Future<void> setFavoritePlaylist(String playListId) async {
    return makeDioRequest<void>(() async {
      await dio.patch(_favoriteTrack(playListId));
    });
  }
}
