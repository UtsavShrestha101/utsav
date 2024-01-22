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
import 'package:saro/features/profile/edit_profile/change_username/cubit/change_username_cubit.dart';
import 'package:saro/features/profile/edit_profile/change_username/cubit/change_username_state.dart';
import 'package:saro/features/profile/profile_page/cubit/profile_cubit.dart';
import 'package:saro/resources/assets.gen.dart';

class ChangeUsernamePage extends StatefulWidget {
  final ProfileCubit profileCubit;
  const ChangeUsernamePage({super.key, required this.profileCubit});

  @override
  State<ChangeUsernamePage> createState() => _ChangeUsernamePageState();
}

class _ChangeUsernamePageState extends State<ChangeUsernamePage>
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
      create: (context) => get<ChangeUsernameCubit>(),
      child: Scaffold(
        appBar: SaroAppBar(
          title: Text(
            "Edit Username",
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
                child: BlocConsumer<ChangeUsernameCubit, ChangeUsernameState>(
              listener: (context, state) {
                if (state.changeUsernameStatus ==
                    ChangeUsernameStatus.failure) {
                  context.showSnackBar(state.errorMsg!);
                } else if (state.changeUsernameStatus ==
                    ChangeUsernameStatus.success) {
                  context.showSnackBar(
                    "Username changed successful",
                  );
                  widget.profileCubit.refreshUserData();
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
                        "Your username is",
                        style: context.labelLarge,
                      ),
                      18.vSizedBox,
                      AppTextField(
                        validator: isStringEmpty,
                        labelText: "username",
                        controller: _usernameController,
                        leading: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Assets.icons.saroUsername.svg(
                            height: 46,
                            width: 46,
                          ),
                        ),
                      ),
                      100.vSizedBox,
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          isLoading: state.changeUsernameStatus ==
                              ChangeUsernameStatus.loading,
                          title: "Save",
                          onPressed: () async {
                            if (isFormValid) {
                              await context
                                  .read<ChangeUsernameCubit>()
                                  .changeUsername(_usernameController.text);
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
