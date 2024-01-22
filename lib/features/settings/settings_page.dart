import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/list_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/widgets/action_list_tile.dart';
import 'package:saro/core/ui/widgets/alert_bottom_sheet.dart';
import 'package:saro/core/ui/widgets/app_text_field.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/core/ui/widgets/saro_app_bar.dart';
import 'package:saro/core/utils/form_validators.dart';
import 'package:saro/features/profile/profile_page/cubit/profile_cubit.dart';
import 'package:saro/features/settings/cubit/premium_amount/premium_amount_cubit.dart';
import 'package:saro/features/settings/cubit/profile_setting/profile_setting_cubit.dart';
import 'package:saro/features/settings/cubit/profile_setting/profile_setting_state.dart';
import 'package:saro/features/settings/widgets/dark_mode_tile.dart';
import 'package:saro/features/settings/widgets/spotify_profile_bottomsheet_view.dart';
import 'package:saro/resources/assets.gen.dart';

class SettingsPage extends StatelessWidget with FormValidators {
  final ProfileCubit profileCubit;
  SettingsPage({super.key, required this.profileCubit});
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool get isFormValid => _formKey.currentState!.validate();
  VoidCallback get clearText => _textController.clear;
  static const _iconSize = 72.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<SettingCubit>(),
      child: Scaffold(
        appBar: const SaroAppBar(
          centerTitle: true,
          text: 'Settings',
        ),
        body: BlocConsumer<SettingCubit, SettingState>(
          listener: (context, state) {
            if (state is FailureState) {
              context.pop();
              context.showSnackBar(state.message);
            } else if (state is SuccessState) {
              context.go(AppRouter.onboarding);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  2.vSizedBox,
                  ActionListTile(
                    leading: Assets.icons.saroHammer.svg(width: _iconSize),
                    title: 'edit profile',
                    onTap: () {
                      context.pushNamed(
                        AppRouter.editProfile,
                        extra: profileCubit,
                      );
                    },
                  ),
                  ActionListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Assets.icons.saroSpotify.svg(width: _iconSize),
                    ),
                    title: 'spotify',
                    onTap: () {
                      context.showBottomSheet(
                          const SpotifyProfileBottomSheetView(),
                          isControlled: true);
                    },
                  ),
                  ActionListTile(
                    leading: Assets.icons.saroBone.svg(width: _iconSize),
                    title: 'Set subscription amount',
                    onTap: () {
                      setsubscriptionAmount(context);
                    },
                  ),
                  DarkModeTile(
                    title: "Dark mode ",
                    leading: Assets.icons.saroDarkMode.svg(width: _iconSize),
                  ),
                  ActionListTile(
                    leading: Assets.icons.saroIck.svg(width: _iconSize),
                    title: 'ick list',
                    onTap: () {},
                  ),
                  ActionListTile(
                    leading:
                        Assets.icons.saro2dBallAndBone.svg(width: _iconSize),
                    title: 'shop',
                    onTap: () {},
                  ),
                  ActionListTile(
                    leading:
                        Assets.icons.saroDeleteAccount.svg(width: _iconSize),
                    title: 'Delete account',
                    onTap: () async {
                      showAlertBottomSheet(
                        "are you sure?",
                        "you won’t be able to revert this!",
                        "Rage quit",
                        context,
                        context.read<SettingCubit>().deleteUser,
                      );
                    },
                  ),
                  ActionListTile(
                    leading: Assets.icons.saroUmbrella.svg(width: _iconSize),
                    title: 'logout',
                    onTap: () {
                      showAlertBottomSheet(
                        "are you sure?",
                        "press logout to continue, or cancel",
                        "Logout",
                        context,
                        context.read<SettingCubit>().logout,
                      );
                    },
                  )
                ].gap(space: 7),
              ),
            );
          },
        ),
      ),
    );
  }

  setsubscriptionAmount(BuildContext context) {
    context.showBottomSheet(
      BlocProvider(
        create: (context) => get<PremiumAmountCubit>()..getUserPremiumAmount(),
        child: BlocConsumer<PremiumAmountCubit, PremiumAmountState>(
          listener: (context, state) {
            if (state.msg != null) {
              context.pop();
              context.showSnackBar(state.msg!);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Set premium subscription amount",
                    style: context.labelLarge,
                  ),
                  10.vSizedBox,
                  AppTextField(
                    validator: isStringEmpty,
                    controller: _textController,
                    labelText: state.premiumAmount.toString(),
                    textInputType: TextInputType.number,
                  ),
                  10.vSizedBox,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: PrimaryButton(
                      isLoading: state.isLoading,
                      onPressed: () async {
                        if (isFormValid) {
                          await context
                              .read<PremiumAmountCubit>()
                              .setPremiumAmount(
                                double.parse(
                                  _textController.text.trim(),
                                ),
                              );
                          clearText();
                        }
                      },
                      title: "Set amount",
                    ),
                  ),
                  5.vSizedBox,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
