import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/user.dart';
import 'package:saro/core/repository/user_repository.dart';

part 'premium_amount_state.dart';

@injectable
class PremiumAmountCubit extends Cubit<PremiumAmountState> {
  final UserRepository _userRepository;
  PremiumAmountCubit(this._userRepository)
      : super(
          PremiumAmountState(
            premiumAmount: _userRepository.user!.premiumCharge!.toDouble(),
          ),
        );

  Future<void> getUserPremiumAmount() async {
    User user = await _userRepository.refreshCurrentUser();
    emit(
      state.copyWith(
        premiumAmount: user.premiumCharge!.toDouble(),
      ),
    );
  }

  Future<void> setPremiumAmount(double subAmount) async {
    try {
      emit(
        state.copyWith(
          msg: null,
          isLoading: true,
        ),
      );
      await _userRepository.setPremiumAmount(subAmount);
      emit(
        state.copyWith(
          msg: "Amount set successful",
          isLoading: false,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          msg: e.message,
        ),
      );
    }
  }
}
