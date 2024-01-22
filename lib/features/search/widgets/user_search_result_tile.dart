// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/user_search_result.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/widgets/user_profile_avatar.dart';
import 'package:saro/resources/assets.gen.dart';

class UserSearchResultTile extends StatelessWidget {
  final UserSearchResult userSearchResult;
  final VoidCallback onTap;

  const UserSearchResultTile({
    super.key,
    required this.userSearchResult,
    required this.onTap,
  });
  final _iconSize = 60.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
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
            child: InkWell(
              onTap: () {
                context.push(
                  AppRouter.userProfile,
                  extra: userSearchResult.id,
                );
              },
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
          ),
          InkWell(
            onTap: onTap,
            child: userSearchResult.isFollowing
                ? Assets.icons.saroFollowed.svg(
                    height: _iconSize,
                    width: _iconSize,
                  )
                : Assets.icons.saroFollow.svg(
                    height: _iconSize,
                    width: _iconSize,
                  ),
          ),
        ],
      ),
    );
  }
}
