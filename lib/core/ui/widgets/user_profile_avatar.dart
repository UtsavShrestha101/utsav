import 'package:flutter/material.dart';
import 'package:saro/core/ui/widgets/network_assets.dart';
import 'package:saro/resources/assets.gen.dart';

class UserProfileAvatar extends StatelessWidget {
  final String? userAvatar;
  final double imgHeight;
  final double imgWidth;
  const UserProfileAvatar(
      {super.key,
      this.userAvatar,
      required this.imgHeight,
      required this.imgWidth});

  @override
  Widget build(BuildContext context) {
    return userAvatar != null && userAvatar!.isNotEmpty
        ? NetworkAssets(
            fileKey: userAvatar!,
            imgHeight: imgHeight,
            imgWidth: imgWidth,
          )
        : Assets.icons.saroLogoHead.svg(
            height: imgHeight,
            width: imgWidth,
          );
  }
}
