import 'package:saro/core/models/user.dart';

class CardState {
  List<CreditCard> cards;
  bool isLoading;
  String? statusMsg;
  CardState({this.cards = const [], this.isLoading = false, this.statusMsg});

  CardState copyWith(
      {List<CreditCard>? cards, bool? isLoading, String? statusMsg}) {
    return CardState(
      cards: cards ?? this.cards,
      isLoading: isLoading ?? this.isLoading,
      statusMsg: statusMsg,
    );
  }
}
