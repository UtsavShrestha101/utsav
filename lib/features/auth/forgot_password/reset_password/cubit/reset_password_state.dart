enum ResetPasswordStatus {
  initial,
  loading,
  success,
  failure,
}

class ResetPasswordState {
  final String? token;
  final String? errorMsg;
  final ResetPasswordStatus? resetPasswordStatus;

  ResetPasswordState({
    this.errorMsg,
    this.token,
    this.resetPasswordStatus = ResetPasswordStatus.initial,
  });

  ResetPasswordState copyWith(
      {String? token,
      String? errorMsg,
      ResetPasswordStatus? resetPasswordStatus}) {
    return ResetPasswordState(
      token: token ?? this.token,
      errorMsg: errorMsg ?? this.errorMsg,
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
    );
  }
}
