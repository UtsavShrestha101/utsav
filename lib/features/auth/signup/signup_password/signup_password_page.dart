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
import 'package:saro/features/auth/signup/signup_password/cubit/signup_password_cubit.dart';
import 'package:saro/features/auth/signup/signup_password/cubit/signup_password_state.dart';
import 'package:saro/resources/assets.gen.dart';

class SignUpPasswordPage extends StatefulWidget {
  final String username;
  final String dob;
  final String email;

  const SignUpPasswordPage({
    super.key,
    required this.username,
    required this.dob,
    required this.email,
  });

  @override
  State<SignUpPasswordPage> createState() => _SignUpPasswordStatePage();
}

class _SignUpPasswordStatePage extends State<SignUpPasswordPage>
    with FormValidators {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  final _iconSize = 46.0;
  bool get isFormValid => _formKey.currentState!.validate();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SaroAppBar(
        centerTitle: true,
        title: Text(
          "Create account",
          style: context.headlineLarge,
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: SingleChildScrollView(
            child: BlocProvider.value(
              value: get<SignupPasswordCubit>(),
              child: BlocConsumer<SignupPasswordCubit, SignupPasswordState>(
                listener: (context, state) {
                  if (state.signupPasswordStatus ==
                      SignupPasswordStatus.failure) {
                    context.showSnackBar(state.errorMsg!);
                  } else if (state.signupPasswordStatus ==
                      SignupPasswordStatus.success) {
                    context.go(AppRouter.home);
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Step 4 to 4",
                            style: context.bodyMedium,
                          ),
                        ),
                        70.vSizedBox,
                        Text(
                          "Set a password",
                          style: context.labelLarge,
                        ),
                        18.vSizedBox,
                        AppTextField(
                          obscureText: obscureText,
                          validator: isValidPassword,
                          labelText: "password",
                          controller: _passwordController,
                          leading: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Assets.icons.saroPassword.svg(
                              height: _iconSize,
                              width: _iconSize,
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
                                      height: _iconSize,
                                      width: _iconSize,
                                    )
                                  : Assets.icons.saroPasswordHide.svg(
                                      height: _iconSize,
                                      width: _iconSize,
                                    ),
                            ),
                          ),
                        ),
                        18.vSizedBox,
                        Text(
                          "Password must contain at least 6 character long",
                          style: context.bodySmall,
                        ),
                        100.vSizedBox,
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            isLoading: state.signupPasswordStatus ==
                                SignupPasswordStatus.loading,
                            title: "Next",
                            onPressed: () {
                              final signupCubit =
                                  context.read<SignupPasswordCubit>();
                              if (isFormValid) {
                                signupCubit.signUp(
                                  widget.username,
                                  widget.email,
                                  _passwordController.text,
                                  widget.dob,
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
