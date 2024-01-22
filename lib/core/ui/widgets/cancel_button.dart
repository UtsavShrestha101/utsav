import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/resources/assets.gen.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CancelButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? context.pop,
      icon: Assets.icons.saroX.svg(width: 26),
    );
  }
}
