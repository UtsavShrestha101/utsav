enum SignupUsernameStatus {
  initial,
  loading,
  success,
  failure,
}

class SignupUsernameState {
  final String? username;
  final String? errorMsg;
  final SignupUsernameStatus? signupUsernameStatus;

  SignupUsernameState({
    this.username,
    this.errorMsg,
    this.signupUsernameStatus = SignupUsernameStatus.initial,
  });

  SignupUsernameState copyWith({
    String? username,
    String? errorMsg,
    SignupUsernameStatus? signupUsernameStatus,
  }) {
    return SignupUsernameState(
      username: username ?? this.username,
      errorMsg: errorMsg ?? this.errorMsg,
      signupUsernameStatus: signupUsernameStatus ?? this.signupUsernameStatus,
    );
  }
}
