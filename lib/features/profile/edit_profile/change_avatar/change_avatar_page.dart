import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/avatar.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/core/ui/widgets/network_assets.dart';
import 'package:saro/core/ui/widgets/saro_app_bar.dart';
import 'package:saro/core/ui/widgets/user_profile_avatar.dart';
import 'package:saro/features/profile/edit_profile/change_avatar/cubit/avatar_cubit.dart';
import 'package:saro/features/profile/edit_profile/change_avatar/cubit/avatar_state.dart';
import 'package:saro/features/profile/edit_profile/change_avatar/cubit/change_avatar_cubit.dart';
import 'package:saro/features/profile/profile_page/cubit/profile_cubit.dart';

class ChangeAvatarPage extends StatelessWidget {
  final ProfileCubit profileCubit;
  const ChangeAvatarPage({super.key, required this.profileCubit});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => get<ChangeAvatarCubit>(),
        ),
        BlocProvider(
          create: (context) => get<AvatarCubit>()..getCharacters(),
        ),
      ],
      child: Scaffold(
        appBar: SaroAppBar(
          title: Text(
            "Change character",
            style: context.titleLarge,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            BlocConsumer<ChangeAvatarCubit, ChangeAvatarState>(
              listener: (context, state) {
                if (state.status == ChangeAvatarStatus.failure) {
                  context.showSnackBar(state.failureMsg!);
                } else if (state.status == ChangeAvatarStatus.success) {
                  profileCubit.refreshUserData();

                  context.showSnackBar("Avatar changed successful");
                }
              },
              builder: (context, state) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.275,
                  child: Center(
                    child: UserProfileAvatar(
                      key: UniqueKey(),
                      userAvatar: state.avatarName,
                      imgHeight: 210,
                      imgWidth: 200,
                    ),
                  ),
                );
              },
            ),
            BlocConsumer<AvatarCubit, AvatarState>(
              listener: (context, state) {
                if (state.status == AvatarStatus.failure) {
                  context.showSnackBar(state.failureMsg!);
                }
              },
              builder: (context, state) {
                return Expanded(
                  child: state.status == AvatarStatus.loading
                      ? const LoadingIndicator(
                          height: 150,
                          width: 150,
                        )
                      : Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 2,
                                color: AppColors.ternary,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Select Character",
                                style: context.labelLarge,
                              ),
                              10.vSizedBox,
                              Expanded(
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 5,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: .75,
                                    // 3 items in each row
                                  ),
                                  itemCount: state.characters.length,
                                  itemBuilder: (context, index) {
                                    Avatar character = state.characters[index];
                                    return Column(
                                      children: [
                                        NetworkAssets(
                                          fileKey: character.url,
                                          imgHeight: 100,
                                          imgWidth: 100,
                                          onTap: () {
                                            final changeCharacterCubit = context
                                                .read<ChangeAvatarCubit>();
                                            changeCharacterCubit.changeAvatar(
                                              character.id,
                                              character.url,
                                            );
                                          },
                                        ),
                                        Center(
                                          child: Text(
                                            character.name,
                                            style: context.bodySmall,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
