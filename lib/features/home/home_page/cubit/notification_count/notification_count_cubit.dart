import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/models/user.dart';
import 'package:saro/core/repository/user_repository.dart';

@injectable
class NotificationCountCubit extends Cubit<int> {
  final UserRepository _userRepository;

  NotificationCountCubit(this._userRepository)
      : super(_userRepository.user!.notificationCount!);

  Future<void> refreshUserNotificationCount() async {
    User user = await _userRepository.refreshCurrentUser();
    emit(user.notificationCount!);
  }
}
