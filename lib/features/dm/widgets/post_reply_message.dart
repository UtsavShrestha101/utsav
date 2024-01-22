import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/models/dm.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/network_assets.dart';
import 'package:saro/features/post/post_page/bloc/post/post_event.dart';

class PostReply extends StatelessWidget {
  final Dm dm;
  final bool belongToCurrentUser;
  const PostReply({
    super.key,
    required this.dm,
    required this.belongToCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRouter.postPage,
          extra: {
            "postId": dm.post!.id,
            "postEvent": LoadAllPostList(),
          },
        );
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Column(
          crossAxisAlignment: belongToCurrentUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: NetworkAssets(
                key: ValueKey(
                  dm.post!.filename!,
                ),
                fileKey: !dm.post!.isPremium
                    ? dm.post!.filetype == FileType.image
                        ? dm.post!.url ?? ""
                        : dm.post!.placeholder!.url
                    : dm.post!.placeholder != null
                        ? dm.post!.placeholder!.url
                        : dm.post!.blurred!.url,
                maxHeight: 300,
              ),
            ),

            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: belongToCurrentUser
                    ? AppColors.secondary
                    : AppColors.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Text(
                dm.text!,
                style: context.bodyMedium,
              ),
            )
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     NetworkAssets(
            //       key: ValueKey(
            //         dm.post!.filename!,
            //       ),
            //       fileKey: dm.post!.isPremium!
            //           ? dm.post!.id
            //           : dm.post!.filetype == FileType.video
            //               ? dm.post!.placeholder ?? ""
            //               : dm.post!.url ?? "",
            //       imgHeight: 103,
            //       imgWidth: 97,
            //       isPremiumContent: dm.post!.isPremium!,
            //     ),
            //     15.hSizedBox,
            //     Expanded(
            //       child: Text(
            //         dm.post!.description ?? "",
            //         style: context.bodyMedium,
            //       ),
            //     ),
            //   ],
            // ),
            // const Divider(
            //   color: AppColors.ternary,
            // ),
            // Text(
            //   dm.text!,
            //   style: context.bodyMedium,
            // ),
          ],
        ),
      ),
    );
  }
}
