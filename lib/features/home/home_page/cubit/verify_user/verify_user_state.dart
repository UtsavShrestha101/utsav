import 'package:saro/core/models/user.dart';

enum VerifyUserStatus {
  initial,
  loading,
  success,
  failure,
}

class VerifyUserState {
  final User user;
  final VerifyUserStatus status;
  final String? failureMessage;

  const VerifyUserState(
    this.user, {
    this.status = VerifyUserStatus.initial,
    this.failureMessage,
  });

  VerifyUserState copyWith({
    VerifyUserStatus? status,
    String? failureMessage,
    User? user,
  }) {
    return VerifyUserState(
      user ?? this.user,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  bool get isUserverified => user.isEmailVerified;
}
