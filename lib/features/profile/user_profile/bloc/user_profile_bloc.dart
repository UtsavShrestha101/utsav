import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/room.dart';
import 'package:saro/core/models/user.dart';
import 'package:saro/core/repository/room_repository.dart';
import 'package:saro/core/repository/user_repository.dart';
import 'package:saro/core/services/audio_service.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

@injectable
class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserRepository _userRepository;
  final RoomRepository _roomRepository;
  final String userId;
  final AudioService _audioService;

  UserProfileBloc(this._userRepository, @factoryParam this.userId,
      this._audioService, this._roomRepository)
      : super(UserProfileState()) {
    on<FetchDataState>(_fetchData);
    on<FollowUserState>(_followUser);
    on<UnFollowUserState>(_unfollowUser);
    on<ReportUserState>(_reportUser);
    on<ScreenShotUserProfileState>(_screenshotUser);
    on<AudioPlayEvent>(_playAudio);
    on<AudioStopEvent>(_stopAudio);
    on<SendMessageState>(_sendMessage);
    on<DmUserState>(_dmUser);
    on<ShareProfileState>(_shareProfile);
  }

  void dispose() {
    if (state.user!.tracks!.isNotEmpty) _audioService.dispose();
  }

  Future<void> _fetchData(
      FetchDataState event, Emitter<UserProfileState> emit) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          msg: null,
        ),
      );
      User user = await _userRepository.getUserInfo(userId);
      if (user.tracks!.isNotEmpty) {
        _audioService.play(user.tracks!.first.previewUrl!);
      }
      emit(
        state.copyWith(
          isLoading: false,
          user: user,
          isFollowing: user.isFollowing,
          roomId: user.roomId,
          isAudioPlaying: user.tracks!.isNotEmpty ? true : false,
          userIds: [
            _userRepository.userId!,
            user.id,
          ],
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          msg: e.message,
        ),
      );
    }
  }

  Future<void> _followUser(
      FollowUserState event, Emitter<UserProfileState> emit) async {
    try {
      emit(
        state.copyWith(msg: null),
      );
      await _userRepository.followUser(userId);
      emit(
        state.copyWith(
          isFollowing: true,
          msg: "User followed",
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          msg: e.message,
        ),
      );
    }
  }

  Future<void> _unfollowUser(
      UnFollowUserState event, Emitter<UserProfileState> emit) async {
    try {
      emit(
        state.copyWith(
          msg: null,
        ),
      );
      await _userRepository.unfollowUser(userId);
      emit(
        state.copyWith(
          isFollowing: false,
          msg: "User unfollowed",
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          msg: e.message,
        ),
      );
    }
  }

  Future<void> _playAudio(
      AudioPlayEvent event, Emitter<UserProfileState> emit) async {
    try {
      _audioService.play(event.audioUrl);
      emit(
        state.copyWith(
          isAudioPlaying: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          msg: e.toString(),
        ),
      );
    }
  }

  Future<void> _stopAudio(
      AudioStopEvent event, Emitter<UserProfileState> emit) async {
    try {
      _audioService.pause();
      emit(
        state.copyWith(
          isAudioPlaying: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          msg: e.toString(),
        ),
      );
    }
  }

  Future<void> _reportUser(
      ReportUserState event, Emitter<UserProfileState> emit) async {
    try {
      emit(
        state.copyWith(
          msg: null,
        ),
      );
      await _userRepository.reportUser(userId, event.reportMsg);
      emit(
        state.copyWith(
          msg: "User reported successfully",
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          msg: e.message,
        ),
      );
    }
  }

  Future<void> _screenshotUser(
      ScreenShotUserProfileState event, Emitter<UserProfileState> emit) async {
    await _userRepository.screenshotUser(userId);
  }

  Future<void> _sendMessage(
      SendMessageState event, Emitter<UserProfileState> emit) async {
    await _roomRepository.sendMessage(
      type: "TEXT",
      message: event.msg,
      userId: userId,
    );
  }

  Future<void> _dmUser(
      DmUserState event, Emitter<UserProfileState> emit) async {
    Room roomData = await _roomRepository.getSingleRooms(state.roomId!);
    RoomUser receiver = roomData.members.firstWhere((e) => e.user.id != userId);
    emit(state.copyWith(roomUser: receiver));
  }

  Future<void> _shareProfile(
      ShareProfileState event, Emitter<UserProfileState> emit) async {
    try {
      await _roomRepository.sendMessage(
        type: "FORWARD_USER",
        userId: event.profileId,
        profileId: userId,
      );
    
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          msg: e.message,
        ),
      );
    }
  }
}
