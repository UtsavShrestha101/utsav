import 'package:flutter/widgets.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/network_assets.dart';

class MediaFile extends StatelessWidget {
  final String fileUrl;
  final double? imgHeight;
  final double? maxHeight;
  final double? imgWidth;
  final bool belongToCurrentUser;
  const MediaFile({
    super.key,
    required this.fileUrl,
    required this.belongToCurrentUser,
    this.imgHeight,
    this.maxHeight,
    this.imgWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: belongToCurrentUser
              ? AppColors.lightSecondary
              : AppColors.lightPrimary,
        ),
        child: NetworkAssets(
          key: ValueKey(fileUrl),
          fileKey: fileUrl,
          imgHeight: imgHeight,
          imgWidth: imgHeight,
          maxHeight: maxHeight,
        ),
      ),
    );
  }
}
