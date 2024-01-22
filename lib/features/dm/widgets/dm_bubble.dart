import 'package:flutter/material.dart';
import 'package:saro/core/models/dm.dart';
import 'package:saro/features/dm/widgets/gift_message.dart';
import 'package:saro/features/dm/widgets/media_file.dart';
import 'package:saro/features/dm/widgets/media_message.dart';
import 'package:saro/features/dm/widgets/post_reply_message.dart';
import 'package:saro/features/dm/widgets/share_post_message.dart';
import 'package:saro/features/dm/widgets/share_profile_message.dart';
import 'package:saro/features/dm/widgets/text_message.dart';

class DmBubble extends StatelessWidget {
  final Dm dm;
  final bool belongToCurrentUser;
  const DmBubble(
      {super.key, required this.dm, required this.belongToCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Align(
        alignment:
            belongToCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            switch (dm.type) {
              DMType.TEXT => TextMessage(
                  belongToCurrentUser: belongToCurrentUser,
                  text: dm.text!,
                ),
              DMType.SOURCE_IMG => MediaFile(
                  fileUrl: dm.sourceImg!,
                  belongToCurrentUser: belongToCurrentUser,
                  imgHeight: 200,
                  imgWidth: double.infinity,
                ),
              DMType.MEDIAS => MediaMessage(
                  dm: dm,
                  belongToCurrentUser: belongToCurrentUser,
                ),
              DMType.REPLY_POST => PostReply(
                  dm: dm,
                  belongToCurrentUser: belongToCurrentUser,
                ),
              DMType.GIFT => GiftMessage(
                  dm: dm,
                  belongToCurrentUser: belongToCurrentUser,
                ),
              DMType.FORWARD_USER => ShareProfileMessage(
                  dm: dm,
                  belongToCurrentUser: belongToCurrentUser,
                ),
              DMType.FORWARD_POST => SharePostMessage(
                  dm: dm,
                  belongToCurrentUser: belongToCurrentUser,
                ),
              DMType.REPLY_DM => const Text("DM reply"),
            },
          ],
        ),
      ),
    );
  }
}
