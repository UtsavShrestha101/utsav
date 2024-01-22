import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/widgets/app_text_field.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/core/ui/widgets/saro_app_bar.dart';
import 'package:saro/core/utils/form_validators.dart';
import 'package:saro/features/auth/forgot_password/reset_password/cubit/reset_password_cubit.dart';
import 'package:saro/features/auth/forgot_password/reset_password/cubit/reset_password_state.dart';
import 'package:saro/resources/assets.gen.dart';

class ForgotPasswordSetNewPage extends StatefulWidget {
  final String token;
  const ForgotPasswordSetNewPage({super.key, required this.token});

  @override
  State<ForgotPasswordSetNewPage> createState() =>
      _ForgotPasswordSetNewPageState();
}

class _ForgotPasswordSetNewPageState extends State<ForgotPasswordSetNewPage>
    with FormValidators {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool get isFormValid => _formKey.currentState!.validate();
  bool obscureText = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<ResetPasswordCubit>(),
      child: Scaffold(
        appBar: SaroAppBar(
          title: Text(
            "Forgot password",
            style: context.headlineLarge,
          ),
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: SingleChildScrollView(
              child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                listener: (context, state) {
                  if (state.resetPasswordStatus ==
                      ResetPasswordStatus.failure) {
                    context.showSnackBar(state.errorMsg!);
                  } else if (state.resetPasswordStatus ==
                      ResetPasswordStatus.success) {
                    context.showSnackBar(
                      "Password reset successfull",
                    );

                    context.goNamed(
                      AppRouter.login,
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
                          "Set a new password",
                          style: context.labelLarge,
                        ),
                        18.vSizedBox,
                        AppTextField(
                          obscureText: obscureText,
                          validator: isValidPassword,
                          labelText: "Password",
                          controller: _passwordController,
                          leading: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Assets.icons.saroPassword.svg(
                              height: 46,
                              width: 46,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: obscureText
                                  ? Assets.icons.saroPasswordView.svg(
                                      height: 46,
                                      width: 46,
                                    )
                                  : Assets.icons.saroPasswordHide.svg(
                                      height: 46,
                                      width: 46,
                                    ),
                            ),
                          ),
                        ),
                        18.vSizedBox,
                        Text(
                          "Password must contain at least 6 character long",
                          style: context.bodySmall,
                        ),
                        250.vSizedBox,
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            isLoading: state.resetPasswordStatus ==
                                ResetPasswordStatus.loading,
                            title: "Next",
                            onPressed: () {
                              final forgotPasswordSetPasswordCubit =
                                  context.read<ResetPasswordCubit>();
                              if (isFormValid) {
                                forgotPasswordSetPasswordCubit.resetPassword(
                                  widget.token,
                                  _passwordController.text,
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
