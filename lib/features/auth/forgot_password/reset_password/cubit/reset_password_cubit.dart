import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/auth_repository.dart';
import 'package:saro/features/auth/forgot_password/reset_password/cubit/reset_password_state.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository _authRepository;

  ResetPasswordCubit(this._authRepository) : super(ResetPasswordState());

  Future<void> resetPassword(String token, String password) async {
    try {
      emit(
        state.copyWith(resetPasswordStatus: ResetPasswordStatus.loading),
      );
      await _authRepository.resetPassword(token, password);

      emit(
        state.copyWith(
          resetPasswordStatus: ResetPasswordStatus.success,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          resetPasswordStatus: ResetPasswordStatus.failure,
          errorMsg: e.message,
        ),
      );
    }
  }
}
