import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/post_detail.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/user_profile_avatar.dart';
import 'package:saro/resources/assets.gen.dart';

class ExpandableCaptionWidget extends StatefulWidget {
  const ExpandableCaptionWidget(
      {super.key, required this.post, this.gotoProfilePage = false});
  final PostDetail post;
  final bool gotoProfilePage;

  @override
  State<ExpandableCaptionWidget> createState() =>
      _ExpandableCaptionWidgetState();
}

class _ExpandableCaptionWidgetState extends State<ExpandableCaptionWidget> {
  bool isCaptionWidgetExpanded = false;

  void toggleCaptionViewExpandState() {
    setState(() => isCaptionWidgetExpanded = !isCaptionWidgetExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserProfileAvatar(
          userAvatar: widget.post.user!.avatar,
          imgHeight: 75,
          imgWidth: 75,
        ),
        10.hSizedBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  if (widget.gotoProfilePage) {
                    context.push(
                      AppRouter.userProfile,
                      extra: widget.post.user!.id,
                    );
                  }
                },
                child: Row(
                  children: [
                    Text(
                      "@${widget.post.user!.username}",
                      style: context.bodyLarge.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    if (widget.post.user!.isIdentityVerified == true)
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
              2.5.vSizedBox,
              GestureDetector(
                onTap: () => toggleCaptionViewExpandState(),
                child: AnimatedCrossFade(
                  secondCurve: Curves.bounceInOut,
                  firstChild: Text(
                    "${widget.post.description}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyMedium.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  secondChild: Text(
                    widget.post.description ?? "",
                    style: context.bodyMedium.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  crossFadeState: isCaptionWidgetExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 150),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
