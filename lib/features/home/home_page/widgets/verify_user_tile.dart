import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/features/home/home_page/cubit/verify_user/verify_user_cubit.dart';
import 'package:saro/features/home/home_page/cubit/verify_user/verify_user_state.dart';
import 'package:saro/features/home/home_page/widgets/verification_bottom_sheet.dart';
import 'package:saro/resources/assets.gen.dart';

class VerifyUserTile extends StatefulWidget {
  const VerifyUserTile({super.key});

  @override
  State<VerifyUserTile> createState() => _VerifyUserTileState();
}

class _VerifyUserTileState extends State<VerifyUserTile> {
  bool showVerifyAlert = true;
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<VerifyUserCubit>(),
      child: BlocConsumer<VerifyUserCubit, VerifyUserState>(
        listener: (context, state) {
          if (state.status == VerifyUserStatus.failure) {
            context.pop();
            context.showSnackBar(state.failureMessage!);
          } else if (state.status == VerifyUserStatus.success) {
            setState(() {
              showVerifyAlert = !showVerifyAlert;
            });
            context.pop();
            context.showSnackBar("User verified successfully");
          }
        },
        builder: (context, state) {
          return showVerifyAlert && !state.isUserverified
              ? Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.ternary,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        5,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "please verify your email.",
                          style:
                              context.bodyMedium.copyWith(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: 124,
                        child: PrimaryButton(
                          onPressed: () async {
                            await context.read<VerifyUserCubit>().sendOtp();
                            if (context.mounted) {
                              showVerifyBottomSheet(
                                context,
                                _codeController,
                              );
                            }
                          },
                          title: "Verify",
                          textStyle: context.labelLarge.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      20.hSizedBox,
                      InkWell(
                        onTap: () {
                          setState(() {
                            showVerifyAlert = !showVerifyAlert;
                          });
                        },
                        child: Assets.icons.saroCancel.svg(
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }
}
