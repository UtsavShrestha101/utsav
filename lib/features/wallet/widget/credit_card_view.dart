import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/date_time.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/user.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/alert_bottom_sheet.dart';
import 'package:saro/core/ui/widgets/app_text_field.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/core/utils/form_validators.dart';
import 'package:saro/features/home/home_page/cubit/verify_user/verify_user_cubit.dart';
import 'package:saro/features/home/home_page/cubit/verify_user/verify_user_state.dart';
import 'package:saro/features/home/home_page/widgets/verification_bottom_sheet.dart';
import 'package:saro/features/wallet/cubit/card_cubit/card_cubit.dart';
import 'package:saro/features/wallet/cubit/card_cubit/card_state.dart';
import 'package:saro/features/wallet/widget/credit_card_tile.dart';
import 'package:saro/resources/assets.gen.dart';

class CreditCardView extends StatefulWidget {
  const CreditCardView({super.key});

  @override
  State<CreditCardView> createState() => _CreditCardViewState();
}

class _CreditCardViewState extends State<CreditCardView> with FormValidators {
  DateTime? dateTime;
  final _cardNumberController = TextEditingController();
  final _countryController = TextEditingController();
  final _zipController = TextEditingController();
  final _cvcController = TextEditingController();
  final _dateController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool get isFormValid => _formKey.currentState!.validate();

  @override
  void dispose() {
    controllerDispose();
    super.dispose();
  }

  controllerDispose() {
    _cardNumberController.dispose();
    _countryController.dispose();
    _zipController.dispose();
    _cvcController.dispose();
    _dateController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => get<CardCubit>()..getUserCard(),
        ),
        BlocProvider(
          create: (context) => get<VerifyUserCubit>(),
        ),
      ],
      child: BlocConsumer<CardCubit, CardState>(
        listener: (BuildContext context, CardState state) {
          if (state.statusMsg != null) {
            context.showSnackBar(state.statusMsg!);
            context.pop();
          }
        },
        builder: (context, state) {
          return state.cards.isEmpty
              ? BlocConsumer<VerifyUserCubit, VerifyUserState>(
                  listener: (BuildContext context, VerifyUserState state) {
                    if (state.status == VerifyUserStatus.success) {
                      context.showSnackBar("User verified");
                      context.pop();
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: size.width * 0.85,
                      child: PrimaryButton(
                        buttonStyle: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            AppColors.secondary,
                          ),
                        ),
                        onPressed: () async {
                          if (state.isUserverified) {
                            _addCardBottomSheet(context);
                          } else {
                            context.showBottomSheet(
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Assets.icons.saroVerify.svg(
                                    height: 100,
                                    width: 100,
                                  ),
                                  30.vSizedBox,
                                  Text(
                                    "Please verify your email before you can use your wallet.",
                                    style: context.bodyLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                  30.vSizedBox,
                                  SizedBox(
                                    width: double.infinity,
                                    child: PrimaryButton(
                                      title: "Verify",
                                      onPressed: () {
                                        context.pop();
                                        context
                                            .read<VerifyUserCubit>()
                                            .sendOtp();
                                        showVerifyBottomSheet(
                                          context,
                                          _otpController,
                                        );
                                      },
                                    ),
                                  ),
                                  30.vSizedBox,
                                ],
                              ),
                            );
                          }
                        },
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add card",
                              style: context.titleLarge.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                            10.hSizedBox,
                            const Icon(
                              Icons.add_circle,
                              color: Colors.white,
                              size: 32,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.cards.length,
                  itemBuilder: (context, index) {
                    CreditCard creditCard = state.cards[index];
                    return CreditCardTile(
                      creditCard: creditCard,
                      onPressed: () {
                        showAlertBottomSheet(
                          "are you sure?",
                          "press remove card to continue, or cancel",
                          "remove card",
                          context,
                          () {
                            context.read<CardCubit>().removeCard(creditCard.id);
                          },
                        );
                      },
                    );
                  });
        },
      ),
    );
  }

  void _addCardBottomSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      builder: (builderContext) {
        return BlocProvider.value(
          value: context.read<CardCubit>(),
          child: Padding(
            padding: EdgeInsets.only(
              right: 15,
              left: 15,
              top: 10,
              bottom: MediaQuery.of(builderContext).viewInsets.bottom,
            ),
            child: SizedBox(
              height: MediaQuery.of(builderContext).size.height * 0.875,
              child: BlocBuilder<CardCubit, CardState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          10.vSizedBox,
                          Text(
                            "card information",
                            style: context.labelLarge,
                          ),
                          7.5.vSizedBox,
                          AppTextField(
                            validator: isCardNoValid,
                            controller: _cardNumberController,
                            textInputType: TextInputType.number,
                            labelText: "card number",
                          ),
                          7.5.vSizedBox,
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  validator: isStringEmpty,
                                  ontap: () async {
                                    dateTime = await showDatePicker(
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2500),
                                      context: context,
                                      initialDate: DateTime.now(),
                                    );
                                    if (dateTime != null) {
                                      _dateController.text = dateTime!.mmYY;
                                    }
                                  },
                                  viewOnly: true,
                                  controller: _dateController,
                                  labelText: "mm/yy",
                                ),
                              ),
                              10.hSizedBox,
                              Expanded(
                                child: AppTextField(
                                  validator: isCvcValid,
                                  controller: _cvcController,
                                  textInputType: TextInputType.number,
                                  labelText: "cvc",
                                ),
                              ),
                            ],
                          ),
                          10.vSizedBox,
                          Text(
                            "Billing address",
                            style: context.labelLarge,
                          ),
                          10.vSizedBox,
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  validator: isStringEmpty,
                                  controller: _countryController,
                                  labelText: "country",
                                ),
                              ),
                              10.hSizedBox,
                              Expanded(
                                child: AppTextField(
                                  validator: isStringEmpty,
                                  controller: _stateController,
                                  labelText: "state",
                                ),
                              ),
                            ],
                          ),
                          7.5.vSizedBox,
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  validator: isStringEmpty,
                                  controller: _cityController,
                                  labelText: "City",
                                ),
                              ),
                              10.hSizedBox,
                              Expanded(
                                child: AppTextField(
                                  validator: isStringEmpty,
                                  controller: _zipController,
                                  textInputType: TextInputType.number,
                                  labelText: "zip",
                                ),
                              ),
                            ],
                          ),
                          7.5.vSizedBox,
                          AppTextField(
                            validator: isStringEmpty,
                            controller: _address1Controller,
                            labelText: "address line 1",
                          ),
                          7.5.vSizedBox,
                          AppTextField(
                            controller: _address2Controller,
                            labelText: "address line 2",
                          ),
                          10.vSizedBox,
                          SizedBox(
                            width: double.infinity,
                            child: PrimaryButton(
                              isLoading: state.isLoading,
                              title: "Save",
                              onPressed: () async {
                                if (isFormValid) {
                                  Map<String, String> cardDetail = {
                                    "number": _cardNumberController.text.trim(),
                                    "exp_month": _dateController.text
                                        .trim()
                                        .split("/")[0],
                                    "exp_year": _dateController.text
                                        .trim()
                                        .split("/")[1],
                                    "cvc": _cvcController.text.trim(),
                                    "address_country":
                                        _countryController.text.trim(),
                                    "address_state":
                                        _stateController.text.trim(),
                                    "address_city": _cityController.text.trim(),
                                    "address_zip": _zipController.text.trim(),
                                    "address_line1":
                                        _address1Controller.text.trim(),
                                    "address_line2": _address2Controller.text
                                        .trim() // optional
                                  };
                                  await context
                                      .read<CardCubit>()
                                      .addCard(cardDetail);
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
