// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_profile_bloc.dart';

class UserProfileState {
  User? user;
  String? msg;
  bool? isLoading;
  bool? isFollowing;
  String? roomId;
  List<String>? userIds;
  RoomUser? roomUser;
  bool isAudioPlaying;
  UserProfileState({
    this.user,
    this.msg,
    this.isLoading,
    this.isFollowing,
    this.roomId,
    this.userIds,
    this.roomUser,
    this.isAudioPlaying = false,
  });

  UserProfileState copyWith({
    User? user,
    bool? isLoading,
    String? msg,
    bool? isFollowing,
    String? roomId,
    List<String>? userIds,
    bool? isAudioPlaying,
    RoomUser? roomUser,
  }) {
    return UserProfileState(
      user: user ?? this.user,
      msg: msg,
      isLoading: isLoading ?? this.isLoading,
      isFollowing: isFollowing ?? this.isFollowing,
      roomId: roomId ?? this.roomId,
      userIds: userIds ?? this.userIds,
      isAudioPlaying: isAudioPlaying ?? this.isAudioPlaying,
      roomUser: roomUser ?? this.roomUser,
    );
  }
}
