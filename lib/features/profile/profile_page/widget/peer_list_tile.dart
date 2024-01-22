import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/models/peer.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/widgets/network_assets.dart';
import 'package:saro/resources/assets.gen.dart';

class PeerListTile extends StatelessWidget {
  final Peer peer;
  const PeerListTile({super.key, required this.peer});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: peer.avatar != null
          ? NetworkAssets(
              fileKey: peer.avatar!,
              imgHeight: 40,
              imgWidth: 40,
            )
          : Assets.icons.saroLogoHead.svg(
              height: 40,
              width: 40,
            ),
      title: InkWell(
        onTap: () {
          context.push(
            AppRouter.userProfile,
            extra: peer.id,
          );
        },
        child: Row(
          children: [
            Text(
              peer.username,
              style: context.bodyLarge,
            ),
            if (peer.isIdentityVerified == true)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 2.5,
                ),
                child: Assets.icons.saroVerify.svg(
                  height: 28,
                  width: 28,
                ),
              ),
            if (peer.type == FollowType.PAID)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 2.5,
                ),
                child: Assets.icons.saroPremium.svg(
                  height: 28,
                  width: 28,
                ),
              )
          ],
        ),
      ),
    );
  }
}
