import 'package:flutter/material.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/resources/assets.gen.dart';

class ActionListTile extends StatelessWidget {
  const ActionListTile({
    super.key,
    this.leading,
    required this.title,
    this.onTap,
  });

  final Widget? leading;

  final VoidCallback? onTap;

  final String title;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        leading: leading,
        title: Text(title, style: context.labelLarge),
        onTap: onTap,
        trailing: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Assets.icons.saroArrowLight.svg(
            width: 28,
            colorFilter: ColorFilter.mode(
                brightness == Brightness.dark ? Colors.white : Colors.black,
                BlendMode.srcIn),
          ),
        ));
  }
}
