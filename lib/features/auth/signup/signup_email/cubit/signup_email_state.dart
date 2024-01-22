enum SignupEmailStatus {
  initial,
  loading,
  success,
  failure,
}

class SignupEmailState {
  final String? username;
  final String? dob;
  final String? email;
  final String? errorMsg;
  final SignupEmailStatus? signupEmailStatus;

  SignupEmailState({
    this.username,
    this.dob,
    this.email,
    this.errorMsg,
    this.signupEmailStatus = SignupEmailStatus.initial,
  });

  SignupEmailState copyWith({
    String? username,
    String? dob,
    String? email,
    String? errorMsg,
    SignupEmailStatus? signupEmailStatus,
  }) {
    return SignupEmailState(
        username: username ?? this.username,
        dob: dob ?? this.dob,
        email: email ?? this.email,
        errorMsg: errorMsg ?? this.errorMsg,
        signupEmailStatus: signupEmailStatus ?? this.signupEmailStatus);
  }
}
