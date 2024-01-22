import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/resources/assets.gen.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Assets.icons.saroLogo.image(
                height: 330,
                width: 330,
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _LogInButton(),
                  _SignUpButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _OnBoardingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String text;
  const _OnBoardingButton({
    required this.onPressed,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            vertical: 16,
          ),
        ),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all(
          const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: context.titleLarge.copyWith(
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _LogInButton extends StatelessWidget {
  const _LogInButton();

  @override
  Widget build(BuildContext context) {
    return _OnBoardingButton(
      onPressed: () => context.goNamed(AppRouter.login),
      color: AppColors.primary,
      text: 'login',
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return _OnBoardingButton(
      onPressed: () => context.goNamed(AppRouter.signUpUsername),
      color: AppColors.secondary,
      text: 'signup',
    );
  }
}
