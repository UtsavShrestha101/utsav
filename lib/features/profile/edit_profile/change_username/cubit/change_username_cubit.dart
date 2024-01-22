import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/user_repository.dart';
import 'package:saro/features/profile/edit_profile/change_username/cubit/change_username_state.dart';

@injectable
class ChangeUsernameCubit extends Cubit<ChangeUsernameState> {
  final UserRepository _userRepository;
  ChangeUsernameCubit(this._userRepository) : super(ChangeUsernameState());

  Future<void> changeUsername(String username) async {
    try {
      emit(state.copywith(changeUsernameStatus: ChangeUsernameStatus.loading));
      await _userRepository.changeUsername(username);
      emit(
        state.copywith(
          changeUsernameStatus: ChangeUsernameStatus.success,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copywith(
          errorMsg: e.message,
          changeUsernameStatus: ChangeUsernameStatus.failure,
        ),
      );
    }
  }
}
