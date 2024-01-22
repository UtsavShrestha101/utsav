import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/features/wallet/cubit/balance_cubit/balance_cubit.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<BalanceCubit>()..getUserCurrentAmount(),
      child: BlocBuilder<BalanceCubit, double>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: AppColors.ternary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "balance",
                  style: context.labelMedium,
                ),
                Text(
                  "\$${state.toStringAsFixed(2)}",
                  style: context.headlineMedium,
                ),
                Text(
                  "minimum withdrawal \$20",
                  style: context.labelSmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
