// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'premium_amount_cubit.dart';

class PremiumAmountState {
  double premiumAmount;
  String? msg;
  bool isLoading;
  PremiumAmountState({
    required this.premiumAmount,
    this.msg ,
    this.isLoading = false,
  });

  PremiumAmountState copyWith({
    double? premiumAmount,
    String? msg,
    bool? isLoading,
  }) {
    return PremiumAmountState(
      premiumAmount: premiumAmount ?? this.premiumAmount,
      msg: msg ?? this.msg,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
