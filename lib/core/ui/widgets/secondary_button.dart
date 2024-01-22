import 'package:flutter/material.dart';
import 'package:saro/core/ui/colors/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final bool isLoading;
  const SecondaryButton({
    super.key,
    this.onPressed,
    required this.title,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.secondary)),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: CircularProgressIndicator(),
            )
          : Text(title),
    );
  }
}
