import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/auth_repository.dart';
import 'package:saro/core/repository/push_notification_repository.dart';
import 'package:saro/features/auth/signup/signup_password/cubit/signup_password_state.dart';

@injectable
class SignupPasswordCubit extends Cubit<SignupPasswordState> {
  final AuthRepository _authRepository;
  final PushNotificationRepository _notificationRepository;

  SignupPasswordCubit(this._authRepository, this._notificationRepository)
      : super(SignupPasswordState());
  Future<void> signUp(
      String username, String email, String password, String dob) async {
    try {
      state.copyWith(signupPasswordStatus: SignupPasswordStatus.loading);

      await _authRepository.signUp(
        username,
        email,
        password,
        dob,
      );
      await _notificationRepository.sendFCMToken();

      emit(
        state.copyWith(
          signupPasswordStatus: SignupPasswordStatus.success,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          signupPasswordStatus: SignupPasswordStatus.failure,
          errorMsg: e.message,
        ),
      );
    }
  }
}
