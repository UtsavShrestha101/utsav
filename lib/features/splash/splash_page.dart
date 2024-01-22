import 'package:flutter/material.dart';
import 'package:saro/resources/assets.gen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Assets.icons.saroLogo.image(height: 330, width: 330),
      ),
    );
  }
}
