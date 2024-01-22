import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/user_search_result.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/core/ui/widgets/user_profile_avatar.dart';
import 'package:saro/features/search/cubit/search_cubit.dart';
import 'package:saro/features/search/cubit/search_state.dart';
import 'package:saro/resources/assets.gen.dart';

class ShareTile extends StatelessWidget {
  final UserSearchResult userSearchResult;
  final VoidCallback onTap;

  const ShareTile({
    super.key,
    required this.userSearchResult,
    required this.onTap,
  });
  final _iconSize = 60.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 2.5,
      ),
      child: Row(
        children: [
          UserProfileAvatar(
            userAvatar: userSearchResult.avatar,
            imgHeight: _iconSize,
            imgWidth: _iconSize,
          ),
          10.hSizedBox,
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '@${userSearchResult.username}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyLarge,
                  ),
                ),
                if (userSearchResult.isIdentityVerified == true)
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
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return PrimaryButton(
                buttonStyle: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                  !state.userIds.contains(userSearchResult.id)
                      ? AppColors.primary
                      : AppColors.secondary,
                )),
                title: state.userIds.contains(userSearchResult.id)
                    ? "Shared"
                    : "Share",
                onPressed: () {
                  if (!state.userIds.contains(userSearchResult.id)) {
                    onTap();
                  }
                },
                textStyle: context.bodyMedium.copyWith(
                  color: AppColors.white,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
