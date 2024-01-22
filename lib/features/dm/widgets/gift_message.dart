import 'package:flutter/widgets.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/dm.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/resources/assets.gen.dart';

class GiftMessage extends StatelessWidget {
  final Dm dm;
  final bool belongToCurrentUser;
  const GiftMessage(
      {super.key, required this.dm, required this.belongToCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                belongToCurrentUser ? AppColors.secondary : AppColors.primary,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (belongToCurrentUser)
              Assets.icons.saroBlueBone.svg(
                height: 30,
                width: 30,
              ),
            5.hSizedBox,
            Text(
              "${belongToCurrentUser ? "you have sent" : "you have received"} \$${dm.gift}",
              style: context.bodyMedium.copyWith(
                color: belongToCurrentUser
                    ? AppColors.secondary
                    : AppColors.primary,
              ),
            ),
            5.hSizedBox,
            if (!belongToCurrentUser)
              Assets.icons.saroPinkBone.svg(
                height: 30,
                width: 30,
              ),
          ],
        ),
      ),
    );
  }
}
