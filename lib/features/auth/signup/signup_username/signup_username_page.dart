import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/typography/text_styles.dart';
import 'package:saro/core/ui/widgets/app_text_field.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/core/ui/widgets/saro_app_bar.dart';
import 'package:saro/core/utils/form_validators.dart';
import 'package:saro/features/auth/signup/signup_username/cubit/signup_username_cubit.dart';
import 'package:saro/features/auth/signup/signup_username/cubit/signup_username_state.dart';
import 'package:saro/resources/assets.gen.dart';

class SignupUsernamePage extends StatefulWidget {
  const SignupUsernamePage({super.key});

  @override
  State<SignupUsernamePage> createState() => _SignupUsernamePageState();
}

class _SignupUsernamePageState extends State<SignupUsernamePage>
    with FormValidators {
  final _usernameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool get isFormValid => _formKey.currentState!.validate();

  @override
  void dispose() {
    _usernameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<SignupUsernameCubit>(),
      child: Scaffold(
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
                value: get<SignupUsernameCubit>(),
                child: BlocConsumer<SignupUsernameCubit, SignupUsernameState>(
                  listener: (context, state) {
                    if (state.signupUsernameStatus ==
                        SignupUsernameStatus.failure) {
                      context.showSnackBar(state.errorMsg!);
                    } else if (state.signupUsernameStatus ==
                        SignupUsernameStatus.success) {
                      context.pushNamed(
                        AppRouter.signUpDob,
                        extra: {
                          "username": state.username!,
                        },
                      );
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
                              "Step 1 to 4",
                              style: context.bodyMedium,
                            ),
                          ),
                          70.vSizedBox,
                          Text(
                            "Your username is",
                            style: context.labelLarge,
                          ),
                          18.vSizedBox,
                          AppTextField(
                            validator: isStringEmpty,
                            labelText: "Username",
                            controller: _usernameController,
                            leading: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Assets.icons.saroUsername.svg(
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
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "By continuing, you agree to our ",
                                  style: context.bodySmall,
                                ),
                                const TextSpan(
                                  text: 'Terms of Service',
                                  style: kLinkTextStyle,
                                ),
                                TextSpan(
                                  text:
                                      " and acknowledge that you have read our ",
                                  style: context.bodySmall,
                                ),
                                const TextSpan(
                                  text: 'Privacy Policy.',
                                  style: kLinkTextStyle,
                                ),
                              ],
                            ),
                          ),
                          30.vSizedBox,
                          SizedBox(
                            width: double.infinity,
                            child: PrimaryButton(
                              isLoading: state.signupUsernameStatus ==
                                  SignupUsernameStatus.loading,
                              title: "Next",
                              onPressed: () {
                                final signupCubit =
                                    context.read<SignupUsernameCubit>();
                                if (isFormValid) {
                                  signupCubit.checkUsername(
                                      _usernameController.text.trim());
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
      ),
    );
  }
}
