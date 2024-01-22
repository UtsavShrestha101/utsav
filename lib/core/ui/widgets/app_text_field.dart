import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? labelText;
  final bool? obscureText;
  final bool? viewOnly;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final VoidCallback? ontap;
  final int maxLines;
  final String? helperText;
  final Widget? leading;
  final Widget? trailing;
  final int? maxLength;
  final Function(String)? onChanged;
  const AppTextField({
    super.key,
    this.viewOnly,
    this.labelText,
    this.obscureText,
    this.controller,
    this.validator,
    this.textInputAction,
    this.textInputType,
    this.maxLines = 1,
    this.helperText,
    this.onChanged,
    this.trailing,
    this.leading,
    this.ontap,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      maxLines: maxLines,
      onChanged: onChanged,
      readOnly: viewOnly ?? false,
      onTap: ontap,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText,
        helperText: helperText,
        prefixIcon: leading,
        suffixIcon: trailing,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        alignLabelWithHint: true,
      ),
      obscureText: obscureText ?? false,
      validator: validator,
    );
  }
}
