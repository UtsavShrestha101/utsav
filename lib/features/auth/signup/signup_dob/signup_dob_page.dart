import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/date_time.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/widgets/app_text_field.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/core/ui/widgets/saro_app_bar.dart';
import 'package:saro/core/utils/form_validators.dart';
import 'package:saro/features/auth/signup/signup_dob/cubit/signup_dob_cubit.dart';
import 'package:saro/features/auth/signup/signup_dob/cubit/signup_dob_state.dart';

class SignUpDobPage extends StatefulWidget {
  final String username;
  const SignUpDobPage({
    super.key,
    required this.username,
  });

  @override
  State<SignUpDobPage> createState() => _SignUpDobPageState();
}

class _SignUpDobPageState extends State<SignUpDobPage> with FormValidators {
  DateTime? currentDateTime;
  final _dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool get isFormValid => _formKey.currentState!.validate();

  @override
  void initState() {
    super.initState();
    currentDateTime = DateTime.now();
  }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _dobController.text = currentDateTime!.dayMonYear;
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
              value: get<SignupDobCubit>(),
              child: BlocConsumer<SignupDobCubit, SignupDobState>(
                listener: (context, state) {
                  if (state.signupDobStatus == SignupDobStatus.failure) {
                    context.showSnackBar(state.errorMsg!);
                  } else if (state.signupDobStatus == SignupDobStatus.success) {
                    context.pushNamed(
                      AppRouter.signUpEmail,
                      extra: {
                        "username": widget.username,
                        "dob": state.dob!,
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
                            "Step 2 to 4",
                            style: context.bodyMedium,
                          ),
                        ),
                        70.vSizedBox,
                        Text(
                          "Your birthday",
                          style: context.labelLarge,
                        ),
                        18.vSizedBox,
                        AppTextField(
                          ontap: () async {
                            currentDateTime =
                                await DatePicker.showSimpleDatePicker(
                              context,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                              dateFormat: "dd-MMMM-yyyy",
                              locale: DateTimePickerLocale.en_us,
                            );
                            _dobController.text = currentDateTime!.dayMonYear;
                          },
                          viewOnly: true,
                          textInputType: TextInputType.datetime,
                          labelText: "DOB",
                          controller: _dobController,
                        ),
                        18.vSizedBox,
                        Text(
                          "You will also be able to change this later in settings",
                          style: context.bodySmall,
                        ),
                        70.vSizedBox,
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            isLoading: state.signupDobStatus ==
                                SignupDobStatus.loading,
                            title: "Next",
                            onPressed: () {
                              final signupCubit =
                                  context.read<SignupDobCubit>();
                              if (isFormValid) {
                                signupCubit.submitDOB(_dobController.text);
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
