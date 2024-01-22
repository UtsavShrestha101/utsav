import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/ui/widgets/app_text_field.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/core/ui/widgets/saro_app_bar.dart';
import 'package:saro/core/utils/form_validators.dart';
import 'package:saro/features/profile/edit_profile/change_password/cubit/change_password_cubit.dart';
import 'package:saro/features/profile/edit_profile/change_password/cubit/change_password_state.dart';
import 'package:saro/resources/assets.gen.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage>
    with FormValidators {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  bool get isFormValid => _formKey.currentState!.validate();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<ChangePasswordCubit>(),
      child: Scaffold(
        appBar: SaroAppBar(
          title: Text(
            "Change Password",
            style: context.titleLarge,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: SingleChildScrollView(
                child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                if (state.changePasswordStatus ==
                    ChangePasswordStatus.failure) {
                  context.showSnackBar(state.errorMsg!);
                } else if (state.changePasswordStatus ==
                    ChangePasswordStatus.success) {
                  context.showSnackBar(
                    "Password changed successful",
                  );
                  context.pop();
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      60.vSizedBox,
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
                      70.vSizedBox,
                      30.vSizedBox,
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          isLoading: state.changePasswordStatus ==
                              ChangePasswordStatus.loading,
                          title: "Save",
                          onPressed: () {
                            if (isFormValid) {
                              context
                                  .read<ChangePasswordCubit>()
                                  .changePassword(
                                    _passwordController.text.trim(),
                                  );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
          ),
        ),
      ),
    );
  }
}
