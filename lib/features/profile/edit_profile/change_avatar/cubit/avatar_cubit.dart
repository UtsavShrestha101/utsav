import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/avatar.dart';
import 'package:saro/core/repository/user_repository.dart';
import 'package:saro/features/profile/edit_profile/change_avatar/cubit/avatar_state.dart';

@injectable
class AvatarCubit extends Cubit<AvatarState> {
  final UserRepository _userRepository;

  AvatarCubit(this._userRepository)
      : super(
          const AvatarState(),
        );



  Future<void> getCharacters() async {
    try {
      emit(
        state.copyWith(
          status: AvatarStatus.loading,
        ),
      );
      List<Avatar> characters = await _userRepository.getCharacters();
      emit(
        state.copyWith(
          status: AvatarStatus.success,
          characters: characters,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: AvatarStatus.failure,
          failureMsg: e.message,
        ),
      );
    }
  }
}
