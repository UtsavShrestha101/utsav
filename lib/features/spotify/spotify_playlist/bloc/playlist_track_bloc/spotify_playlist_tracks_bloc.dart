import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/spotify_searched_track.dart';
import 'package:saro/core/repository/spotify_repository.dart';
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_track_bloc/spotify_playlist_tracks_event.dart';
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_track_bloc/spotify_playlist_tracks_state.dart';

@injectable
class SpotifyPlaylistTracksBloc
    extends Bloc<SpotifyPlaylistTrackEvent, SpotifyPlaylistTrackState> {
  final SpotifyRepository _spotifyPlaylistRepository;
  final String playlistId;
  SpotifyPlaylistTracksBloc(
    this._spotifyPlaylistRepository,
    @factoryParam this.playlistId,
  ) : super(const SpotifyPlaylistTrackState()) {
    on<FetchPlaylistTrackEvent>(getPlayList, transformer: droppable());
  }

  Future<void> getPlayList(FetchPlaylistTrackEvent event,
      Emitter<SpotifyPlaylistTrackState> emit) async {
    try {
      if (state.hasReachedMax) return;
      emit(
        state.copyWith(
          isLoading: true,
          failureMsg: null,
        ),
      );

      List<SpotifySearchedTrack> playlist =
          await _spotifyPlaylistRepository.getSpotifyPlaylistTrack(
        playlistId,
        page: state.page,
      );
      return emit(
        state.copyWith(
          isLoading: false,
          spotifyPlaylistTracks: [
            ...state.spotifyPlaylistTracks,
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
