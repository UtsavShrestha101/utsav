enum ChangePasswordStatus {
  initial,
  loading,
  success,
  failure,
}

class ChangePasswordState {
  final String? errorMsg;
  final ChangePasswordStatus? changePasswordStatus;

  ChangePasswordState({
    this.errorMsg,
    this.changePasswordStatus = ChangePasswordStatus.initial,
  });

  ChangePasswordState copywith({
    String? errorMsg,
    ChangePasswordStatus? changePasswordStatus,
  }) {
    return ChangePasswordState(
      errorMsg: errorMsg ?? this.errorMsg,
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
    );
  }
}
