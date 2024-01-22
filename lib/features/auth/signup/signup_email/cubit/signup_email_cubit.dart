import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/auth_repository.dart';
import 'package:saro/features/auth/signup/signup_email/cubit/signup_email_state.dart';

@injectable
class SignupEmailCubit extends Cubit<SignupEmailState> {
  final AuthRepository _authRepository;

  SignupEmailCubit(this._authRepository) : super(SignupEmailState());

  Future<void> submitEmail(String email) async {
    emit(
      state.copyWith(signupEmailStatus: SignupEmailStatus.loading),
    );

    try {
      bool isEmailValid = await _authRepository.isAvailable(email: email);
      if (isEmailValid) {
        emit(
          state.copyWith(
            signupEmailStatus: SignupEmailStatus.success,
            email: email,
          ),
        );
      } else {
        emit(
          state.copyWith(
            signupEmailStatus: SignupEmailStatus.failure,
            errorMsg: "Email already used.\nPlease try again.",
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
            signupEmailStatus: SignupEmailStatus.failure, errorMsg: e.message),
      );
    }
  }
}
