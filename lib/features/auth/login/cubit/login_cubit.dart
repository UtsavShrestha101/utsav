import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/auth_repository.dart';
import 'package:saro/core/repository/push_notification_repository.dart';
import 'package:saro/features/auth/login/cubit/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  final PushNotificationRepository _notificationRepository;

  LoginCubit(this._authRepository, this._notificationRepository)
      : super(LoggingInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(LoggingIn());
      await _authRepository.logIn(email, password);
      await _notificationRepository.sendFCMToken();
      emit(LoginSuccess());
    } on NetworkException catch (e) {
      emit(LoginFailed(e.message));
    }
  }

  void reset() => emit(LoggingInitial());
}
