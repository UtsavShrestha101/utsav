import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/dm.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/user_profile_avatar.dart';
import 'package:saro/resources/assets.gen.dart';

class ShareProfileMessage extends StatelessWidget {
  final Dm dm;
  final bool belongToCurrentUser;
  const ShareProfileMessage(
      {super.key, required this.dm, required this.belongToCurrentUser});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          AppRouter.userProfile,
          extra: dm.user!.id,
        );
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            color: belongToCurrentUser
                ? AppColors.lightSecondary
                : AppColors.lightPrimary,
          ),
          child: Column(
            children: [
              UserProfileAvatar(
                key: ValueKey(dm.user!.avatar),
                userAvatar: dm.user!.avatar,
                imgHeight: 138,
                imgWidth: 138,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "@${dm.user!.username}",
                    style: context.bodyLarge,
                  ),
                  if (dm.user!.isIdentityVerified == true)
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.5,
                  vertical: 7.5,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: belongToCurrentUser
                        ? const Color.fromRGBO(110, 207, 246, 1)
                        : AppColors.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    )),
                child: Center(
                  child: Row(
                    children: [
                      Assets.icons.saroForward.svg(
                        height: 25,
                        width: 25,
                      ),
                      7.5.hSizedBox,
                      Text(
                        "Shared Profile",
                        style: context.bodySmall,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
