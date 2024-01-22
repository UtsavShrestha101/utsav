

class SettingState {}

class InitialState extends SettingState {}

class LoadingState extends SettingState {}

class SuccessState extends SettingState {}

class FailureState extends SettingState {
  final String message;

  FailureState(this.message);
}
