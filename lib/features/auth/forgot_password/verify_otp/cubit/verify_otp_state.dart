enum VerifyOtpStatus {
  initial,
  loading,
  success,
  failure,
  resendOtp,
}

class VerifyOtpState {
  final String? code;
  final String? token;
  final String? errorMsg;
  final VerifyOtpStatus? verifyOtpStatus;

  VerifyOtpState({
    this.code,
    this.errorMsg,
    this.token,
    this.verifyOtpStatus = VerifyOtpStatus.initial,
  });

  VerifyOtpState copyWith(
      {String? code,
      String? token,
      String? errorMsg,
      VerifyOtpStatus? verifyOtpStatus}) {
    return VerifyOtpState(
      code: code ?? this.code,
      token: token ?? this.token,
      errorMsg: errorMsg ?? this.errorMsg,
      verifyOtpStatus: verifyOtpStatus ?? this.verifyOtpStatus,
    );
  }
}
