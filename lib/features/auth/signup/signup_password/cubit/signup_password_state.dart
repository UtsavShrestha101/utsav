enum SignupPasswordStatus {
  initial,
  loading,
  success,
  failure,
}

class SignupPasswordState {
  final String? username;
  final String? dob;
  final String? email;
  final String? password;
  final String? errorMsg;
  final SignupPasswordStatus? signupPasswordStatus;

  SignupPasswordState({
    this.username,
    this.dob,
    this.email,
    this.password,
    this.errorMsg,
    this.signupPasswordStatus,
  });

  SignupPasswordState copyWith({
    String? username,
    String? dob,
    String? email,
    String? password,
    String? errorMsg,
    SignupPasswordStatus? signupPasswordStatus,
  }) {
    return SignupPasswordState(
      username: username ?? this.username,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMsg: errorMsg ?? this.errorMsg,
      signupPasswordStatus: signupPasswordStatus ?? this.signupPasswordStatus,
    );
  }
}
