import 'package:flutter/material.dart';
import 'package:saro/core/models/dm.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/features/dm/widgets/media_file.dart';

class MediaMessage extends StatelessWidget {
  final Dm dm;
  final bool belongToCurrentUser;
  const MediaMessage(
      {super.key, required this.dm, required this.belongToCurrentUser});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: dm.medias!.length == 1
          ? mediaView(dm.medias![0])
          : GridView.builder(
              key: ValueKey(dm.mediaGroupId),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              itemCount: dm.medias!.length,
              itemBuilder: (context, index) {
                DmMedia media = dm.medias![index];
                return mediaView(media);
              },
            ),
    );
  }

  Widget mediaView(DmMedia media) {
    return media.filetype == FileType.image
        ? MediaFile(
            fileUrl: media.url,
            belongToCurrentUser: belongToCurrentUser,
            maxHeight: 300,
          )
        : Stack(
            key: ValueKey(media.id),
            alignment: Alignment.center,
            children: [
              MediaFile(
                fileUrl: media.placeholder!.url,
                belongToCurrentUser: belongToCurrentUser,
                maxHeight: 300,
              ),
              const Icon(
                Icons.play_circle_outline_outlined,
                color: AppColors.primary,
                size: 80,
              ),
            ],
          );
  }
}
