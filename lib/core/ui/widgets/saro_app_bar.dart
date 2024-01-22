import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/resources/assets.gen.dart';

class SaroAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SaroAppBar({
    super.key,
    this.text,
    this.title,
    this.actions,
    this.leading,
    this.textColor = AppColors.black,
    this.useDarkIcon = true,
    this.automaticallyImplyLeading = true,
    this.centerTitle,
    this.onBackButtonPress,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String? text;

  final Color textColor;

  final Widget? title;

  final List<Widget>? actions;

  final VoidCallback? onBackButtonPress;

  final Widget? leading;

  final bool useDarkIcon;

  final bool automaticallyImplyLeading;

  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading ??
          (automaticallyImplyLeading
              ? IconButton(
                  onPressed: onBackButtonPress ?? context.pop,
                  icon: RotatedBox(
                    quarterTurns: 2,
                    child: brightness == Brightness.light
                        ? Assets.icons.saroArrowLight.svg(
                            width: 30,
                          )
                        : Assets.icons.saroArrowDark.svg(
                            width: 30,
                          ),
                  ),
                )
              : null),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: title ??
          Text(
            text ?? '',
            style: context.headlineMedium,
          ),
      actions: actions,
      centerTitle: centerTitle ?? false,
    );
  }
}
