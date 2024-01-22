import 'package:flutter/widgets.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/post_detail.dart';
import 'package:saro/core/ui/widgets/user_profile_avatar.dart';
import 'package:saro/resources/assets.gen.dart';

class PostStatsTile extends StatelessWidget {
  final UserData user;
  const PostStatsTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 2.5,
      ),
      child: Row(
        children: [
          UserProfileAvatar(
            userAvatar: user.avatar,
            imgHeight: 54,
            imgWidth: 54,
          ),
          7.5.hSizedBox,
          Expanded(
            child: Text(
              "@${user.username}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.bodyLarge,
            ),
          ),
          if (user.count != null)
            Row(
              children: [
                Text(
                  user.count.toString(),
                  style: context.bodyMedium,
                ),
                8.hSizedBox,
                Assets.icons.saroLurking.svg(
                  height: 40,
                  width: 40,
                ),
              ],
            )
        ],
      ),
    );
  }
}
