import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/auth_repository.dart';
import 'package:saro/core/repository/user_repository.dart';
import 'package:saro/features/settings/cubit/profile_setting/profile_setting_state.dart';

@injectable
class SettingCubit extends Cubit<SettingState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  SettingCubit(this._userRepository, this._authRepository)
      : super(
          SettingState(),
        );

  Future<void> deleteUser() async {
    try {
      emit(LoadingState());
      await _userRepository.deleteUser();
      emit(SuccessState());
    } on NetworkException catch (e) {
      emit(FailureState(e.message));
    }
  }

  Future<void> logout() async {
    await _authRepository.logOut();
  }
}
