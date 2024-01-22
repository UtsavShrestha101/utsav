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
import 'package:saro/core/utils/form_validators.dart';
import 'package:saro/features/auth/login/cubit/login_cubit.dart';
import 'package:saro/features/auth/login/cubit/login_state.dart';
import 'package:saro/resources/assets.gen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with FormValidators {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  bool get isFormValid => _formKey.currentState!.validate();
  String get email => _emailController.text;
  String get password => _passwordController.text;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => get<LoginCubit>(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
              if (state is LoginFailed) {
                context.showSnackBar(state.message);
              } else if (state is LoginSuccess) {
                context.go(AppRouter.home);
              }
            }, builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Assets.icons.saroLogo.image(height: 330, width: 330),
                    AppTextField(
                      leading: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Assets.icons.saroMail.svg(height: 46, width: 46),
                      ),
                      controller: _emailController,
                      labelText: 'email',
                      validator: isValidEmail,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                    ),
                    18.vSizedBox,
                    AppTextField(
                      leading: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Assets.icons.saroPassword.svg(
                          height: 46,
                          width: 46,
                        ),
                      ),
                      controller: _passwordController,
                      labelText: 'password',
                      obscureText: obscureText,
                      validator: isValidPassword,
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
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                    ),
                    20.vSizedBox,
                    Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            context.pushNamed(
                              AppRouter.forgotPasswordEmail,
                            );
                          },
                          child: Text(
                            "Forgot Password ?",
                            style: context.bodyMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        )),
                    44.vSizedBox,
                    PrimaryButton(
                      title: "Login",
                      isLoading: state is LoggingIn,
                      onPressed: () {
                        context.unfocus();
                        final loginCubit = context.read<LoginCubit>();
                        loginCubit.reset();
                        if (isFormValid) {
                          loginCubit.login(email, password);
                        }
                      },
                    ),
                    30.vSizedBox,
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don\'t have an account? ',
                            style: context.bodyMedium,
                          ),
                          TextSpan(
                            text: 'Sign up',
                            style: context.bodyMedium.copyWith(
                              color: AppColors.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  context.goNamed(AppRouter.signUpUsername),
                          )
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
