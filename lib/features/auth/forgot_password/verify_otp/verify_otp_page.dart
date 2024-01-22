import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/app_text_field.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/core/ui/widgets/saro_app_bar.dart';
import 'package:saro/core/utils/form_validators.dart';
import 'package:saro/features/auth/forgot_password/verify_otp/cubit/verify_otp_cubit.dart';
import 'package:saro/features/auth/forgot_password/verify_otp/cubit/verify_otp_state.dart';

class ForgotPasswordCodePage extends StatefulWidget {
  final String email;
  const ForgotPasswordCodePage({super.key, required this.email});

  @override
  State<ForgotPasswordCodePage> createState() => _ForgotPasswordCodePageState();
}

class _ForgotPasswordCodePageState extends State<ForgotPasswordCodePage>
    with FormValidators {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool get isFormValid => _formKey.currentState!.validate();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<VerifyOtpCubit>(),
      child: Scaffold(
        appBar: SaroAppBar(
          centerTitle: true,
          title: Text(
            "Forgot password",
            style: context.titleLarge,
          ),
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: SingleChildScrollView(
              child: BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
                listener: (context, state) {
                  if (state.verifyOtpStatus == VerifyOtpStatus.failure) {
                    context.showSnackBar(state.errorMsg!);
                  } else if (state.verifyOtpStatus == VerifyOtpStatus.success) {
                    context.pushNamed(
                      AppRouter.forgotPasswordNewPassword,
                      extra: {
                        "token": state.token!,
                      },
                    );
                  } else if (state.verifyOtpStatus ==
                      VerifyOtpStatus.resendOtp) {
                    context.showSnackBar(
                      "OTP has been sent to your mailbox.",
                    );
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        70.vSizedBox,
                        Text(
                          "Please type the verification code sent to ${widget.email}",
                          style: context.labelLarge,
                        ),
                        18.vSizedBox,
                        AppTextField(
                          textInputType: TextInputType.number,
                          labelText: "Code here",
                          controller: _codeController,
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
                                  style: context.bodyMedium.copyWith(
                                    color: AppColors.primary,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      final forgotPasswordCodeCubit =
                                          context.read<VerifyOtpCubit>();
                                      forgotPasswordCodeCubit.resendOTP(
                                        widget.email,
                                      );
                                    })
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        250.vSizedBox,
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            isLoading: state.verifyOtpStatus ==
                                VerifyOtpStatus.loading,
                            title: "Next",
                            onPressed: () {
                              final forgotPasswordCodeCubit =
                                  context.read<VerifyOtpCubit>();
                              if (isFormValid) {
                                forgotPasswordCodeCubit.submitOTP(
                                  widget.email,
                                  _codeController.text,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
