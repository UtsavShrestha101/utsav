import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/user_repository.dart';
import 'package:saro/features/profile/edit_profile/change_password/cubit/change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final UserRepository _userRepository;
  ChangePasswordCubit(this._userRepository) : super(ChangePasswordState());

  Future<void> changePassword(String password) async {
    try {
      emit(state.copywith(changePasswordStatus: ChangePasswordStatus.loading));
      await _userRepository.changePassword(password);
      emit(state.copywith(
        
        changePasswordStatus: ChangePasswordStatus.success,
      ));
    } on NetworkException catch (e) {
      emit(
        state.copywith(
          errorMsg: e.message,
          changePasswordStatus: ChangePasswordStatus.failure,
        ),
      );
    }
  }
}
