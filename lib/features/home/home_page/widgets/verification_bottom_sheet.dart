import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/ui/typography/text_styles.dart';
import 'package:saro/core/ui/widgets/app_text_field.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/features/home/home_page/cubit/verify_user/verify_user_cubit.dart';
import 'package:saro/features/home/home_page/cubit/verify_user/verify_user_state.dart';

Future<void> showVerifyBottomSheet(
  BuildContext context,
  TextEditingController textEditingController,
) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    useRootNavigator: true,
    context: context,
    builder: (builderContext) {
      return BlocProvider.value(
        value: context.read<VerifyUserCubit>(),
        child: BlocBuilder<VerifyUserCubit, VerifyUserState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(
                right: 10,
                left: 10,
                bottom: MediaQuery.of(builderContext).viewInsets.bottom,
              ),
              child: Form(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          35.vSizedBox,
                          Text(
                            "Please type the verification code sent to ${state.user.email}",
                            style: context.labelLarge,
                          ),
                          18.vSizedBox,
                          AppTextField(
                            textInputType: TextInputType.number,
                            labelText: "Code here",
                            controller: textEditingController,
                          ),
                          13.vSizedBox,
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Didn’t receive any code? ",
                                  style: context.bodyMedium,
                                ),
                                TextSpan(
                                    text: 'Resend Code',
                                    style: kLinkTextStyle.copyWith(
                                        fontSize: context.bodyMedium.fontSize
                                        // context.bodyMedium,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context
                                            .read<VerifyUserCubit>()
                                            .sendOtp();
                                      })
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          16.vSizedBox,
                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: PrimaryButton(
                              title: 'Verify',
                              textStyle: context.titleLarge.copyWith(
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                context
                                    .read<VerifyUserCubit>()
                                    .verifyOtp(textEditingController.text);
                              },
                            ),
                          ),
                          16.vSizedBox,
                          Center(
                            child: InkWell(
                              onTap: () {
                                context.pop();
                              },
                              child: Text(
                                "Cancel",
                                style: context.labelLarge,
                              ),
                            ),
                          ),
                          16.vSizedBox,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
