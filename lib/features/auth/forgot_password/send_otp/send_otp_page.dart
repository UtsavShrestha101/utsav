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
import 'package:saro/features/auth/forgot_password/send_otp/cubit/send_otp_cubit.dart';
import 'package:saro/features/auth/forgot_password/send_otp/cubit/send_otp_state.dart';
import 'package:saro/resources/assets.gen.dart';

class ForgotPasswordEmailPage extends StatefulWidget {
  const ForgotPasswordEmailPage({super.key});

  @override
  State<ForgotPasswordEmailPage> createState() =>
      _ForgotPasswordEmailPageState();
}

class _ForgotPasswordEmailPageState extends State<ForgotPasswordEmailPage>
    with FormValidators {
      
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
    return BlocProvider(
      create: (context) => get<SendOtpCubit>(),
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
              child: BlocConsumer<SendOtpCubit, SendOtpState>(
                listener: (context, state) {
                  if (state.sendOtpStatus == SendOtpStatus.failure) {
                    context.showSnackBar(state.errorMsg!);
                  } else if (state.sendOtpStatus == SendOtpStatus.success) {
                    context.pushNamed(
                      AppRouter.forgotPasswordCode,
                      extra: {
                        "email": state.email!,
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
                        70.vSizedBox,
                        Text(
                          "Enter the email address associated with your account",
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
                            child: Assets.icons.saroMail
                                .svg(height: 46, width: 46),
                          ),
                        ),
                        250.vSizedBox,
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            isLoading:
                                state.sendOtpStatus == SendOtpStatus.loading,
                            title: "Next",
                            onPressed: () {
                              final forgotPasswordEmailCubit =
                                  context.read<SendOtpCubit>();
                              if (isFormValid) {
                                forgotPasswordEmailCubit
                                    .submitEmail(_emailController.text);
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
