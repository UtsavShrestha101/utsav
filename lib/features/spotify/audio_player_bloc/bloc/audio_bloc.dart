import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/models/spotify_searched_track.dart';
import 'package:saro/core/repository/spotify_repository.dart';
import 'package:saro/core/repository/user_repository.dart';
import 'package:saro/core/services/audio_service.dart';
import 'package:saro/core/services/database_service.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_event.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_state.dart';

@injectable
class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioService _audioService;
  final LocalDatabaseService _localDatabaseService;
  final SpotifyRepository spotifyRepository;
  final UserRepository userRepository;

  AudioBloc(this._audioService, this._localDatabaseService,
      this.spotifyRepository, this.userRepository)
      : super(AudioState(
            userProfileTrack: _localDatabaseService.currentUser != null &&
                    (_localDatabaseService.currentUser!.tracks!.isNotEmpty)
                ? _localDatabaseService.currentUser!.tracks![0]
                : SpotifySearchedTrack())) {
    on<AudioPlayEvent>(playAudio, transformer: droppable());
    on<AudioPauseEvent>(pauseAudio, transformer: droppable());
    on<AudioStopEvent>(stopAudio, transformer: droppable());
    on<AudioResumeEvent>(resumeAudio, transformer: droppable());
    on<FavoriteAudio>(favoriteAudio);
  }

  Future<void> playAudio(AudioPlayEvent event, Emitter<AudioState> emit) async {
    try {
      final SpotifySearchedTrack userProfileTrack =
          _localDatabaseService.currentUser!.tracks![0];
      SpotifySearchedTrack? playTrack = event.track ?? userProfileTrack;

      _audioService.play(playTrack.previewUrl ?? "");
      emit(
        state.copyWith(
          status: AudioPlayerStatus.playing,
          spotifyPlaylistItem: event.spotifyPlaylistItem,
          track: playTrack,
        ),
      );
    } catch (e) {
      emit(state.copyWith(failureMsg: e.toString()));
    }
  }

  Future<void> pauseAudio(
      AudioPauseEvent event, Emitter<AudioState> emit) async {
    try {
      _audioService.pause();
      emit(
        state.copyWith(
          status: AudioPlayerStatus.paused,
        ),
      );
    } catch (e) {
      emit(state.copyWith(failureMsg: e.toString()));
    }
  }

  Future<void> stopAudio(AudioStopEvent event, Emitter<AudioState> emit) async {
    try {
      _audioService.stop();
      emit(
        state.copyWith(
          status: AudioPlayerStatus.initial,
        ),
      );
    } catch (e) {
      emit(state.copyWith(failureMsg: e.toString()));
    }
  }

  Future<void> resumeAudio(
      AudioResumeEvent event, Emitter<AudioState> emit) async {
    try {
      _audioService.resume();
      emit(
        state.copyWith(
          status: AudioPlayerStatus.playing,
        ),
      );
    } catch (e) {
      emit(state.copyWith(failureMsg: e.toString()));
    }
  }

  Future<void> favoriteAudio(
      FavoriteAudio event, Emitter<AudioState> emit) async {
    try {
      await spotifyRepository
          .setFavoritePlaylist(event.track.uri!.split(":").last);
      await userRepository.refreshCurrentUser();
      emit(state.copyWith(
        userProfileTrack: event.track,
      ));
    } catch (e) {
      emit(state.copyWith(failureMsg: e.toString()));
    }
  }
}
