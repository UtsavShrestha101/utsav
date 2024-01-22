import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/list_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/widgets/action_list_tile.dart';
import 'package:saro/core/ui/widgets/saro_app_bar.dart';
import 'package:saro/features/profile/profile_page/cubit/profile_cubit.dart';
import 'package:saro/resources/assets.gen.dart';

class EditProfilePage extends StatelessWidget {
  final ProfileCubit profileCubit;
  const EditProfilePage({super.key, required this.profileCubit});
  static const _iconSize = 72.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SaroAppBar(
        title: Text(
          "Edit Profile",
          style: context.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                2.vSizedBox,
                ActionListTile(
                  leading: Assets.icons.saroHammer.svg(width: _iconSize),
                  title: 'Change Character',
                  onTap: () {
                    context.pushNamed(
                      AppRouter.changeCharacter,
                      extra: profileCubit,
                    );
                  },
                ),
                ActionListTile(
                  leading: Assets.icons.saroUsername.svg(width: _iconSize),
                  title: 'Change Username',
                  onTap: () {
                    context.pushNamed(
                      AppRouter.changeUsername,
                      extra: profileCubit,
                    );
                  },
                ),
                ActionListTile(
                  leading: Assets.icons.saroPassword.svg(width: _iconSize),
                  title: 'Change Password',
                  onTap: () {
                    context.pushNamed(AppRouter.changePassword);
                  },
                ),
              ].gap(space: 7),
            ),
          ),
        ),
      ),
    );
  }
}
