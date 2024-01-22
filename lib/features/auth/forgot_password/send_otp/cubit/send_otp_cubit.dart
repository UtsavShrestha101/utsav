import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/auth_repository.dart';
import 'package:saro/features/auth/forgot_password/send_otp/cubit/send_otp_state.dart';

@injectable
class SendOtpCubit extends Cubit<SendOtpState> {
  final AuthRepository _authRepository;

  SendOtpCubit(this._authRepository) : super(SendOtpState());

  Future<void> submitEmail(String email) async {
    try {
      emit(
        state.copyWith(sendOtpStatus: SendOtpStatus.loading),
      );
      await _authRepository.requestOtp(email);

      emit(
        state.copyWith(
          email: email,
          sendOtpStatus: SendOtpStatus.success,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          sendOtpStatus: SendOtpStatus.failure,
          errorMsg: e.message,
        ),
      );
    }
  }
}
