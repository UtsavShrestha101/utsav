import 'package:flutter/material.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/models/user.dart';
import 'package:saro/core/ui/colors/app_colors.dart';

class CreditCardTile extends StatelessWidget {
  final CreditCard creditCard;
  final VoidCallback onPressed;
  const CreditCardTile(
      {super.key, required this.creditCard, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      height: 155,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "primary card",
                style: context.bodyLarge.copyWith(
                  color: AppColors.white,
                ),
              ),
              InkWell(
                onTap: onPressed,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ],
          ),
          Text(
            "${'*' * 8}${creditCard.last4}",
            style: context.titleLarge.copyWith(
              color: AppColors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${creditCard.exp_month}/${creditCard.exp_year}",
                style: context.bodyMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
              Text(
                "***",
                style: context.bodyMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
              Text(
                creditCard.brand,
                style: context.bodyMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
