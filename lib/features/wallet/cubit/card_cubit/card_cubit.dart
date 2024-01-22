import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/user.dart';
import 'package:saro/core/repository/user_repository.dart';
import 'package:saro/core/repository/wallet_repository.dart';
import 'package:saro/features/wallet/cubit/card_cubit/card_state.dart';

@injectable
class CardCubit extends Cubit<CardState> {
  final WalletRepository _walletRepository;
  final UserRepository _userRepository;

  CardCubit(this._walletRepository, this._userRepository)
      : super(CardState(cards: _userRepository.user!.cards ?? []));

  Future<void> getUserCard() async {
    User user = await _userRepository.refreshCurrentUser();
    emit(
      state.copyWith(
        cards: user.cards,
      ),
    );
  }

  Future<void> removeCard(String cardID) async {
    emit(
      state.copyWith(
        statusMsg: null,
      ),
    );
    await _walletRepository.deleteCard(cardID);
    await getUserCard();
    emit(
      state.copyWith(
        statusMsg: "Card deleted",
      ),
    );
  }

  Future<void> addCard(Map<String, String> cardDetail) async {
    try {
      emit(
        state.copyWith(isLoading: true, statusMsg: null),
      );
      await _walletRepository.addCard(cardDetail);
      await getUserCard();
      emit(
        state.copyWith(isLoading: false, statusMsg: "Card added successfully"),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          statusMsg: e.message,
        ),
      );
    }
  }

  Future<void> transferAmount(double amount, String userId) async {
    try {
      emit(
        state.copyWith(isLoading: true, statusMsg: null),
      );
      await _walletRepository.transferAmount(amount, userId);
      emit(
        state.copyWith(isLoading: false, statusMsg: "Gift sent"),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          statusMsg: e.message,
        ),
      );
    }
  }
}
