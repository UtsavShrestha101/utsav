import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/user.dart';
import 'package:saro/core/repository/user_repository.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository;

  ProfileCubit(this._userRepository)
      : super(ProfileState(_userRepository.currentUser!));

  Future<void> refreshUserData() async {
    try {
      User user = await _userRepository.refreshCurrentUser();
      emit(
        state.copyWith(
          user: user,
          failureMsg: null,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          failureMsg: e.message,
        ),
      );
    }
  }

  Future<void> verificationSession() async {
    try {
      String url = await _userRepository.verificationSession();
      emit(
        state.copyWith(
          sessionUrl: url,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          failureMsg: e.message,
        ),
      );
    }
  }
}
