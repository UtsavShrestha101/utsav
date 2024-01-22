import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/repository/user_repository.dart';

part 'change_avatar_state.dart';

@injectable
class ChangeAvatarCubit extends Cubit<ChangeAvatarState> {
  final UserRepository _userRepository;
  ChangeAvatarCubit(this._userRepository)
      : super(
          ChangeAvatarState(_userRepository.currentUser!.avatar ?? ""),
        );

  Future<void> changeAvatar(String avatar, String avatarName) async {
    try {
      await _userRepository.changeAvatar(avatar, avatarName);
      emit(state.copyWith(
        avatarName: avatarName,
        status: ChangeAvatarStatus.success,
      ));
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          failureMsg: e.message,
          status: ChangeAvatarStatus.failure,
        ),
      );
    }
  }
}
