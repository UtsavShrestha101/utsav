import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/auth_repository.dart';
import 'package:saro/features/auth/signup/signup_username/cubit/signup_username_state.dart';

@injectable
class SignupUsernameCubit extends Cubit<SignupUsernameState> {
  final AuthRepository _authRepository;

  SignupUsernameCubit(this._authRepository) : super(SignupUsernameState());

  Future<void> checkUsername(String name) async {
    emit(
      state.copyWith(signupUsernameStatus: SignupUsernameStatus.loading),
    );
    try {
      bool isUsernameValid = await _authRepository.isAvailable(userName: name);
      if (isUsernameValid) {
        emit(
          state.copyWith(
            signupUsernameStatus: SignupUsernameStatus.success,
            username: name,
          ),
        );
      } else {
        emit(
          state.copyWith(
            signupUsernameStatus: SignupUsernameStatus.failure,
            errorMsg: "Username already used.\nPlease try again.",
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
            signupUsernameStatus: SignupUsernameStatus.failure,
            errorMsg: e.message),
      );
    }
  }
}
