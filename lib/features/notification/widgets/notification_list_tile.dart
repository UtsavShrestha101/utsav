import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/date_time.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/notification.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/widgets/user_profile_avatar.dart';
import 'package:saro/resources/assets.gen.dart';

class NotificationListTile extends StatelessWidget {
  final UserNotification userNotification;
  const NotificationListTile({super.key, required this.userNotification});
  final _imageSize = 60.0;

  String notificationMsg(NotificationType type) {
    switch (type) {
      case NotificationType.LIKE_POST:
        return "likes your squeak.";
      case NotificationType.REMOVE_LIKE_POST:
        return "removed like from your squeak.";
      case NotificationType.DISLIKE_POST:
        return "doesn't like your post.";
      case NotificationType.REMOVE_DISLIKE_POST:
        return "removed dislike from your post.";
      case NotificationType.FOLLOW:
        return "followed you";
      case NotificationType.PAID_FOLLOW:
        return "paid followed you";
      case NotificationType.UNFOLLOW:
        return "unfollowed you";
      case NotificationType.REPORT_POST:
        return "reported your post";
      case NotificationType.REPORT_USER:
        return "reported your profile";
      case NotificationType.TAG_POST:
        return "tagged you";
      case NotificationType.CREDIT:
        return "sent you \$${userNotification.transaction!.amount}";
      case NotificationType.DEBIT:
        return "you sent \$${userNotification.transaction!.amount}";
      case NotificationType.WITHDRAW:
        return "WITHDRAW";
      case NotificationType.SCREENSHOTPOST:
        return "screenshot your squeak";
      case NotificationType.SCREENSHOTPROFILE:
        return "screenshot your profile";
      default:
        return "notification";
    }
  }

  Widget notificationImage(
    NotificationType type,
    double imageSize,
  ) {
    switch (type) {
      case NotificationType.LIKE_POST:
        return Assets.icons.saroLove.svg(height: imageSize, width: imageSize);
      case NotificationType.REMOVE_LIKE_POST:
      case NotificationType.DISLIKE_POST:
      case NotificationType.REMOVE_DISLIKE_POST:
        return Assets.icons.saroHate.svg(height: imageSize, width: imageSize);
      case NotificationType.REPORT_POST:
      case NotificationType.REPORT_USER:
        return Assets.icons.saroReport.svg(height: imageSize, width: imageSize);
      case NotificationType.FOLLOW:
      case NotificationType.PAID_FOLLOW:
        return Assets.icons.saroFollowNotification
            .svg(height: imageSize, width: imageSize);
      case NotificationType.UNFOLLOW:
        return Assets.icons.saroUnfollowed
            .svg(height: imageSize, width: imageSize);
      case NotificationType.SCREENSHOTPOST:
      case NotificationType.SCREENSHOTPROFILE:
        return Assets.icons.saroScreenshot
            .svg(height: imageSize, width: imageSize);
      case NotificationType.CREDIT:
      case NotificationType.DEBIT:
        return Assets.icons.saroBone.svg(height: imageSize, width: imageSize);
      default:
        return Assets.icons.saroLogoHead
            .svg(height: imageSize, width: imageSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        children: [
          UserProfileAvatar(
            userAvatar: userNotification.sender.avatar,
            imgHeight: 75,
            imgWidth: 75,
          ),
          15.hSizedBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    context.push(
                      AppRouter.userProfile,
                      extra: userNotification.sender.id,
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        "@${userNotification.sender.username}",
                        style: context.bodyLarge,
                      ),
                      if (userNotification.sender.isIdentityVerified == true)
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
                  notificationMsg(
                    userNotification.type,
                  ),
                  style: context.bodySmall,
                ),
                2.5.vSizedBox,
                Text(
                  DateTime.fromMillisecondsSinceEpoch(userNotification.createdAt).relativeTime,
                  style: context.labelSmall,
                ),
              ],
            ),
          ),
          notificationImage(
            userNotification.type,
            _imageSize,
          ),
        ],
      ),
    );
  }
}
