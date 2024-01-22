enum SignupDobStatus {
  initial,
  loading,
  success,
  failure,
}

class SignupDobState {
  final String? username;
  final String? dob;
  final String? errorMsg;
  final SignupDobStatus? signupDobStatus;

  SignupDobState({
    this.username,
    this.dob,
    this.errorMsg,
    this.signupDobStatus = SignupDobStatus.initial,
  });

  SignupDobState copyWith(
      {String? username,
      String? dob,
      String? errorMsg,
      SignupDobStatus? signupDobStatus}) {
    return SignupDobState(
        username: username ?? this.username,
        dob: dob ?? this.dob,
        errorMsg: errorMsg ?? this.errorMsg,
        signupDobStatus: signupDobStatus ?? this.signupDobStatus);
  }
}
