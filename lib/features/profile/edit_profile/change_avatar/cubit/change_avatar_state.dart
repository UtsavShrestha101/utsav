part of 'change_avatar_cubit.dart';

enum ChangeAvatarStatus { initial, loading, success, failure }

class ChangeAvatarState {
  final String avatarName;
  final String? failureMsg;
  final ChangeAvatarStatus status;

  const ChangeAvatarState(
    this.avatarName, {
    this.failureMsg,
    this.status = ChangeAvatarStatus.initial,
  });

  ChangeAvatarState copyWith({
    String? avatarName,
    String? failureMsg,
    ChangeAvatarStatus? status,
  }) {
    return ChangeAvatarState(
      avatarName ?? this.avatarName,
      failureMsg: failureMsg ?? this.failureMsg,
      status: status ?? this.status,
    );
  }
}
