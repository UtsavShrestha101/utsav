import 'package:flutter/material.dart';

class PostOptionButton extends StatelessWidget {
  final VoidCallback ontap;
  final Widget widget;
  const PostOptionButton({
    super.key,
    required this.widget,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: widget,
    );
  }
}
