import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/models/user.dart';
import 'package:saro/core/repository/user_repository.dart';

@injectable
class BalanceCubit extends Cubit<double> {
  final UserRepository _userRepository;

  BalanceCubit(this._userRepository)
      : super(_userRepository.user!.amount!.toDouble());

  Future<void> getUserCurrentAmount() async {
    User user = await _userRepository.refreshCurrentUser();
    emit(user.amount!.toDouble());
  }
}
