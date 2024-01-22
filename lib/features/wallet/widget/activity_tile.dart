import 'package:flutter/material.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/date_time.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/notification.dart';
import 'package:saro/core/ui/colors/app_colors.dart';

class ActivityTile extends StatelessWidget {
  final bool isReceived;
  final UserNotification notification;
  const ActivityTile({
    super.key,
    required this.isReceived,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: isReceived ? AppColors.secondary : AppColors.primary,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isReceived ? "Receive" : "Send",
                style: context.bodySmall.copyWith(
                  color: isReceived ? AppColors.secondary : AppColors.primary,
                ),
              ),
              Text(
                "${!isReceived ? '-' : ''}\$${notification.transaction!.netAmount.toStringAsFixed(2)}",
                style: context.bodyLarge,
              ),
            ],
          ),
          7.5.vSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "@${notification.sender.username}",
                  style: context.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Text(
                DateTime.fromMillisecondsSinceEpoch(notification.createdAt)
                    .relativeTime,
                style: context.labelSmall,
              ),
            ],
          )
        ],
      ),
    );
  }
}
