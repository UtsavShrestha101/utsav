part of 'profile_cubit.dart';

class ProfileState {
  final User user;
  final String? failureMsg;
  final String? sessionUrl;

  ProfileState(
    this.user, {
    this.failureMsg,
    this.sessionUrl,
  });

  ProfileState copyWith(
      {User? user, String? failureMsg, String? sessionUrl}) {
    return ProfileState(
      user ?? this.user,
      failureMsg: failureMsg,
      sessionUrl: sessionUrl,
    );
  }
}
