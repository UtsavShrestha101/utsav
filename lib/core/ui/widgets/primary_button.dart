import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final bool isLoading;
  final Widget? widget;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;
  const PrimaryButton({
    super.key,
    this.title,
    this.onPressed,
    this.isLoading = false,
    this.textStyle,
    this.widget,
    this.buttonStyle,
  });


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: buttonStyle,
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4,
              ),
              child: CircularProgressIndicator(),
            )
          : widget ??
              Text(
                title ?? "",
                style: textStyle ?? const TextStyle(color: Colors.white),
              ),
    );
  }
}
