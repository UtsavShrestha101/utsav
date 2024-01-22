import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/spotify_playlist.dart';
import 'package:saro/core/repository/spotify_repository.dart';
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_bloc/playlist_event.dart';
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_bloc/playlist_state.dart';

@injectable
class SpotifyPlaylistBloc extends Bloc<PlaylistEvent, SpotifyPlaylistState> {
  final SpotifyRepository _spotifyPlaylistRepository;

  SpotifyPlaylistBloc(this._spotifyPlaylistRepository)
      : super(const SpotifyPlaylistState()) {
    on<FetchPlaylistEvent>(getPlayList, transformer: droppable());
  }

  Future<void> getPlayList(
      FetchPlaylistEvent event, Emitter<SpotifyPlaylistState> emit) async {
    try {
      if (state.hasReachedMax) return;
      emit(
        state.copyWith(
          isLoading: true,
          failureMsg: null,
        ),
      );

      List<SpotifyPlaylistItem> playlist =
          await _spotifyPlaylistRepository.getSpotifyPlaylist(
        state.page,
      );
      return emit(
        state.copyWith(
          isLoading: false,
          spotifyPlaylist: [
            ...state.spotifyPlaylist,
            ...playlist,
          ],
          page: state.page + 1,
          hasReachedMax: playlist.length < 10 ? true : false,
        ),
      );
    } on NetworkException catch (e) {
      emit(state.copyWith(failureMsg: e.toString()));
    }
  }
}
