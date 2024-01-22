// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/auth_repository.dart';
import 'package:saro/features/auth/forgot_password/verify_otp/cubit/verify_otp_state.dart';

@injectable
class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final AuthRepository _authRepository;

  VerifyOtpCubit(this._authRepository) : super(VerifyOtpState());

  Future<void> submitOTP(String email, String otp) async {
    try {
      emit(
        state.copyWith(verifyOtpStatus: VerifyOtpStatus.loading),
      );
      String? token = await _authRepository.verifyResetOTP(email, otp);
      if (token != null) {
        emit(
          state.copyWith(
              token: token, verifyOtpStatus: VerifyOtpStatus.success),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          verifyOtpStatus: VerifyOtpStatus.failure,
          errorMsg: e.message,
        ),
      );
    }
  }

  Future<void> resendOTP(
    String email,
  ) async {
    try {
      emit(
        state.copyWith(verifyOtpStatus: VerifyOtpStatus.loading),
      );
      await _authRepository.requestOtp(email);
      emit(
        state.copyWith(

          verifyOtpStatus: VerifyOtpStatus.resendOtp,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          verifyOtpStatus: VerifyOtpStatus.failure,
          errorMsg: e.message,
        ),
      );
    }
  }
}
