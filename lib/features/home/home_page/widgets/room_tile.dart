import 'package:flutter/material.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/dm.dart';
import 'package:saro/core/models/room.dart';
import 'package:saro/core/extensions/date_time.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/user_profile_avatar.dart';
import 'package:saro/resources/assets.gen.dart';

class RoomTile extends StatelessWidget {
  const RoomTile({
    super.key,
    required this.room,
    required this.onTap,
    required this.isViewed,
    required this.belongToCurrentUser,
    required this.receiver,
    required this.unreadCount,
  });

  final Room room;
  final VoidCallback onTap;
  final RoomUser receiver;
  final bool isViewed;
  final bool belongToCurrentUser;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 16,
        ),
        child: SizedBox(
          height: 95,
          child: Row(
            children: [
              UserProfileAvatar(
                userAvatar: receiver.user.avatar,
                imgHeight: 84,
                imgWidth: 84,
              ),
              10.hSizedBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "@${receiver.user.username}",
                                style: context.bodyLarge,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              if (receiver.user.isIdentityVerified == true)
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
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                  room.latestMessage.createdAt)
                              .hrMin,
                          style: context.labelSmall,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            switch (room.latestMessage.type) {
                              DMType.TEXT =>
                                "${belongToCurrentUser ? 'you: ' : ''}${room.latestMessage.text}",
                              DMType.SOURCE_IMG =>
                                "${belongToCurrentUser ? 'you: ' : ''}media sent",
                              DMType.MEDIAS =>
                                "${belongToCurrentUser ? 'you: ' : ''}file sent",
                              DMType.REPLY_POST =>
                                "${belongToCurrentUser ? 'you: ' : ''}post reply",
                              DMType.GIFT =>
                                "${belongToCurrentUser ? 'you: ' : ''}gif sent",
                              DMType.FORWARD_USER =>
                                "${belongToCurrentUser ? 'you: ' : ''}shared profile",
                              DMType.FORWARD_POST =>
                                "${belongToCurrentUser ? 'you: ' : ''}shared story",
                              DMType.REPLY_DM => "dm reply",
                            },
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.bodyMedium.copyWith(
                              color: belongToCurrentUser
                                  ? brightness == Brightness.dark
                                      ? AppColors.lightPrimary
                                      : AppColors.black
                                  : isViewed
                                      ? brightness == Brightness.dark
                                          ? AppColors.lightPrimary
                                          : AppColors.black
                                      : AppColors.primary,
                            ),
                          ),
                        ),
                        if (!isViewed)
                          Text(
                            unreadCount.toString(),
                            style: context.bodySmall.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                      ],
                    ),
                    const Divider(
                      color: AppColors.grey,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
