enum ChangeUsernameStatus {
  initial,
  loading,
  success,
  failure,
}

class ChangeUsernameState {
  final String? errorMsg;
  final ChangeUsernameStatus? changeUsernameStatus;

  ChangeUsernameState({
    this.errorMsg,
    this.changeUsernameStatus = ChangeUsernameStatus.initial,
  });

  ChangeUsernameState copywith({
    String? errorMsg,
    ChangeUsernameStatus? changeUsernameStatus,
  }) {
    return ChangeUsernameState(
      errorMsg: errorMsg ?? this.errorMsg,
      changeUsernameStatus: changeUsernameStatus ?? this.changeUsernameStatus,
    );
  }
}
