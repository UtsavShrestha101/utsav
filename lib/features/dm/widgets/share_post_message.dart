import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/dm.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/features/dm/widgets/media_file.dart';
import 'package:saro/features/post/post_page/bloc/post/post_event.dart';
import 'package:saro/resources/assets.gen.dart';

class SharePostMessage extends StatelessWidget {
  final Dm dm;
  final bool belongToCurrentUser;
  const SharePostMessage(
      {super.key, required this.dm, required this.belongToCurrentUser});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          AppRouter.postPage,
          extra: {
            "postId": dm.post!.id,
            "postEvent": LoadAllPostList(),
          },
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
              MediaFile(
                maxHeight: 300,
                fileUrl: !dm.post!.isPremium
                    ? dm.post!.filetype == FileType.image
                        ? dm.post!.url ?? ""
                        : dm.post!.placeholder!.url
                    : dm.post!.placeholder != null
                        ? dm.post!.placeholder!.url
                        : dm.post!.blurred!.url,
                belongToCurrentUser: belongToCurrentUser,
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
                        "Shared story",
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
