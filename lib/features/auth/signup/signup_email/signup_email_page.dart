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
import 'package:saro/features/auth/signup/signup_email/cubit/signup_email_cubit.dart';
import 'package:saro/features/auth/signup/signup_email/cubit/signup_email_state.dart';
import 'package:saro/resources/assets.gen.dart';

class SignUpEmailPage extends StatefulWidget {
  final String username;
  final String dob;
  const SignUpEmailPage({
    super.key,
    required this.username,
    required this.dob,
  });

  @override
  State<SignUpEmailPage> createState() => _SignUpEmailStatePage();
}

class _SignUpEmailStatePage extends State<SignUpEmailPage> with FormValidators {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool get isFormValid => _formKey.currentState!.validate();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SaroAppBar(
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
              value: get<SignupEmailCubit>(),
              child: BlocConsumer<SignupEmailCubit, SignupEmailState>(
                listener: (context, state) {
                  if (state.signupEmailStatus == SignupEmailStatus.failure) {
                    context.showSnackBar(state.errorMsg!);
                  } else if (state.signupEmailStatus ==
                      SignupEmailStatus.success) {
                    context.pushNamed(AppRouter.signUpPassword, extra: {
                      "username": widget.username,
                      "dob": widget.dob,
                      "email": state.email!,
                    });
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
                            "Step 3 to 4",
                            style: context.bodyMedium,
                          ),
                        ),
                        70.vSizedBox,
                        Text(
                          "Add email address",
                          style: context.labelLarge,
                        ),
                        18.vSizedBox,
                        AppTextField(
                          textInputType: TextInputType.emailAddress,
                          validator: isValidEmail,
                          labelText: "email",
                          controller: _emailController,
                          leading: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Assets.icons.saroMail.svg(
                              height: 46,
                              width: 46,
                            ),
                          ),
                        ),
                        18.vSizedBox,
                        Text(
                          "You will also be able to change this later in settings",
                          style: context.bodySmall,
                        ),
                        70.vSizedBox,
                        30.vSizedBox,
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            isLoading: state.signupEmailStatus ==
                                SignupEmailStatus.loading,
                            title: "Next",
                            onPressed: () {
                              final signupCubit =
                                  context.read<SignupEmailCubit>();
                              if (isFormValid) {
                                signupCubit.submitEmail(_emailController.text);
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
