import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/spotify_repository.dart';
import 'package:saro/core/repository/user_repository.dart';
import 'package:saro/features/spotify/spotify_widget/cubit/spotify_auth_state.dart';

@injectable
class SpotifyAuthCubit extends Cubit<SpotifyAuthState> {
  final SpotifyRepository _spotifyRepository;
  final UserRepository _userRepository;
  SpotifyAuthCubit(this._spotifyRepository, this._userRepository)
      : super(const SpotifyAuthState(false, failureMsg: ""));

  Future<void> isUserConnectedToSpotify() async {
    try {
      final res = await _spotifyRepository.isUserConnectedToSpotify();

      if (res) {
        emit(state.copyWith(isUserAuthenticated: true));
      } else {
        emit(state.copyWith(isUserAuthenticated: false));
      }
    } on NetworkException catch (e) {
      emit(
          state.copyWith(isUserAuthenticated: false, failureMsg: e.toString()));
    }
  }

  Future<void> checkLogInSuccess() async {
    try {
      emit(state.copyWith(spotifyLoginStatus: SpotifyLoginStatus.loading));
      final result = await _spotifyRepository.checkLogInSuccess();
      if (result) {
        emit(
          state.copyWith(
            spotifyLoginStatus: SpotifyLoginStatus.success,
            isUserAuthenticated: true,
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          spotifyLoginStatus: SpotifyLoginStatus.failure,
          failureMsg: e.toString(),
          isUserAuthenticated: false,
        ),
      );
    }
  }

  Future<void> getSpotifyDetail() async {
    try {
      emit(state.copyWith(spotifyDetailStatus: SpotifyDetailStatus.loading));
      final result = await _spotifyRepository.getSpotifyDetail();

      emit(state.copyWith(
          spotifyDetailStatus: SpotifyDetailStatus.success,
          spotifyDetail: result));
    } on NetworkException catch (e) {
      emit(state.copyWith(
        failureMsg: e.message.toString(),
      ));
    }
  }

  Future<void> logout() async {
    try {
      await _spotifyRepository.logout();
      await _userRepository.refreshCurrentUser();
      emit(state.copyWith(isUserAuthenticated: false));
    } on NetworkException catch (e) {
      emit(state.copyWith(
        failureMsg: e.toString(),
      ));
    }
  }

  String getSpotifyLoginUrlWithUserId() {
    return _spotifyRepository.getSpotifyLoginUrl();
  }

  String getAccessToken() {
    return _spotifyRepository.getAuthToken();
  }
}
