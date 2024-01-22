abstract class LoginState {}

class LoggingInitial extends LoginState {}

class LoggingIn extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {
  final String message;
  LoginFailed(this.message);
}
