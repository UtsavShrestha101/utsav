// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/user.dart';
import 'package:saro/core/repository/user_repository.dart';
import 'package:saro/features/home/home_page/cubit/verify_user/verify_user_state.dart';

@injectable
class VerifyUserCubit extends Cubit<VerifyUserState> {
  final UserRepository _userRepository;

  VerifyUserCubit(this._userRepository)
      : super(
          VerifyUserState(
            _userRepository.database.currentUser!,
          ),
        );

  Future<void> sendOtp() async {
    try {
      emit(
        state.copyWith(
          status: VerifyUserStatus.loading,
        ),
      );
      await _userRepository.sendVerifyOtp();
    } on NetworkException catch (e) {
      emit(state.copyWith(
        status: VerifyUserStatus.failure,
        failureMessage: e.message,
      ));
    }
  }

  Future<void> refreshUser() async {
    User user = await _userRepository.refreshCurrentUser();
    emit(state.copyWith(user: user));
  }

  Future<void> verifyOtp(String otp) async {
    try {
      emit(
        state.copyWith(
          status: VerifyUserStatus.loading,
        ),
      );
      await _userRepository.verifyOtp(otp);
      await refreshUser();
      emit(
        state.copyWith(
          status: VerifyUserStatus.success,
        ),
      );
    } on NetworkException catch (e) {
      emit(state.copyWith(
        status: VerifyUserStatus.failure,
        failureMessage: e.message,
      ));
    }
  }
}
