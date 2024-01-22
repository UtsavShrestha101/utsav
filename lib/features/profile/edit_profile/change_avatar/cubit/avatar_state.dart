import 'package:saro/core/models/avatar.dart';

enum AvatarStatus { initial, loading, success, failure }

class AvatarState {
  final String? failureMsg;
  final AvatarStatus status;
  final List<Avatar> characters;

  const AvatarState({
    this.failureMsg,
    this.status = AvatarStatus.initial,
    this.characters = const [],
  });

  AvatarState copyWith({
    String? failureMsg,
    AvatarStatus? status,
    List<Avatar>? characters,
  }) {
    return AvatarState(
      failureMsg: failureMsg ?? this.failureMsg,
      status: status ?? this.status,
      characters: characters ?? this.characters,
    );
  }
}
