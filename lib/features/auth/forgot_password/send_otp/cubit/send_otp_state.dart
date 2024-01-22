enum SendOtpStatus {
  initial,
  loading,
  success,
  failure,
}

class SendOtpState {
  final String? email;
  final String? errorMsg;
  final SendOtpStatus? sendOtpStatus;

  SendOtpState({
    this.email,
    this.errorMsg,
    this.sendOtpStatus = SendOtpStatus.initial,
  });

  SendOtpState copyWith({
    String? email,
    String? errorMsg,
    SendOtpStatus? sendOtpStatus,
  }) {
    return SendOtpState(
      email: email ?? this.email,
      errorMsg: errorMsg ?? this.errorMsg,
      sendOtpStatus:
          sendOtpStatus ?? this.sendOtpStatus,
    );
  }
}
