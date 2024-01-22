part of 'user_profile_bloc.dart';

sealed class UserProfileEvent {}

class FetchDataState extends UserProfileEvent {}

class FollowUserState extends UserProfileEvent {}

class UnFollowUserState extends UserProfileEvent {}

class ShareProfileState extends UserProfileEvent {
  final String profileId;

  ShareProfileState(this.profileId);
}

class ScreenShotUserProfileState extends UserProfileEvent {}

class DmUserState extends UserProfileEvent {}

class SendMessageState extends UserProfileEvent {
  final String msg;
  SendMessageState(this.msg);
}

class ReportUserState extends UserProfileEvent {
  final String reportMsg;
  ReportUserState(this.reportMsg);
}

class AudioPlayEvent extends UserProfileEvent {
  final String audioUrl;
  AudioPlayEvent(this.audioUrl);
}

class AudioStopEvent extends UserProfileEvent {}
