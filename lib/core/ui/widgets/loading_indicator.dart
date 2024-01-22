import 'package:flutter/material.dart';
import 'package:saro/resources/assets.gen.dart';

class LoadingIndicator extends StatelessWidget {
  final double height;
  final double width;
  const LoadingIndicator({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Assets.gif.saroSpinner.image(
      height: height,
      width: width,
      fit: BoxFit.contain,
    );
  }
}
