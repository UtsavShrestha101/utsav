// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/action_list_tile.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/core/ui/widgets/user_profile_avatar.dart';
import 'package:saro/features/profile/profile_page/cubit/profile_cubit.dart';
import 'package:saro/features/profile/profile_page/widget/profile_info_view.dart';
import 'package:saro/features/spotify/spotify_widget/spotify_widget.dart';
import 'package:saro/resources/assets.gen.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key});

  final _imageSize = 55.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.failureMsg != null) {
          context.showSnackBar(state.failureMsg!);
        } else if (state.sessionUrl != null) {
          context.push(
            AppRouter.verificationSessionPage,
            extra: {
              "url": state.sessionUrl,
              "cubit": context.read<ProfileCubit>()
            },
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "@${state.user.username}",
                          style: context.bodyLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        if (state.user.isIdentityVerified == true)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2.5,
                            ),
                            child: Assets.icons.saroVerify.svg(
                              height: 28,
                              width: 28,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      padding: const EdgeInsets.only(top: 5.0),
                      onPressed: () async {
                        await context.showBottomSheet(
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ActionListTile(
                                leading: Assets.icons.saroHammer.svg(width: 72),
                                title: 'Settings',
                                onTap: () {
                                  context.pop();
                                  context.pushNamed(
                                    AppRouter.settings,
                                    extra: context.read<ProfileCubit>(),
                                  );
                                },
                              ),
                              15.vSizedBox,
                            ],
                          ),
                        );
                      },
                      icon:
                          Assets.icons.saroHamburger.svg(height: 50, width: 50),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  UserProfileAvatar(
                    key: ValueKey(state.user.avatar),
                    userAvatar: state.user.avatar,
                    imgHeight: 138,
                    imgWidth: 138,
                  ),
                  if (!state.user.isIdentityVerified)
                    SizedBox(
                      height: 45,
                      child: PrimaryButton(
                        onPressed: () async {
                          await context
                              .read<ProfileCubit>()
                              .verificationSession();
                        },
                        title: "Get Verified",
                        textStyle: context.bodyLarge.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  10.vSizedBox,
                  const SpotifyWidget(),
                  10.vSizedBox,
                  const DottedLine(
                    lineThickness: 1.0,
                    dashColor: AppColors.grey,
                  ),
                  5.vSizedBox,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileInfoView(
                        title: "Besties",
                        value: state.user.bestiesCount.toString(),
                        image: Assets.icons.saroUsername.svg(
                          height: _imageSize,
                          width: _imageSize,
                        ),
                      ),
                      ProfileInfoView(
                        title: "Lukers",
                        value: state.user.lurkersCount.toString(),
                        image: Assets.icons.saroLurking.svg(
                          height: _imageSize,
                          width: _imageSize,
                        ),
                      ),
                      ProfileInfoView(
                        title: "Loves",
                        value: state.user.likesCount.toString(),
                        image: Assets.icons.saroLove.svg(
                          height: _imageSize,
                          width: _imageSize,
                        ),
                      ),
                      ProfileInfoView(
                        title: "haters",
                        value: state.user.hatersCount.toString(),
                        image: Assets.icons.saroHate.svg(
                          height: _imageSize,
                          width: _imageSize,
                        ),
                      ),
                    ],
                  ),
                  5.vSizedBox,
                  const DottedLine(
                    lineThickness: 1.0,
                    dashColor: AppColors.grey,
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
