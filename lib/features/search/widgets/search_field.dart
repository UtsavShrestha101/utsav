import 'package:flutter/material.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/resources/assets.gen.dart';

class SearchField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? label;
  final ValueChanged<String>? onChange;
  final VoidCallback? onSearchPressed;
  final bool? showIcon;
  final FocusNode? focusNode;
  const SearchField(
      {super.key,
      this.onChange,
      this.focusNode,
      this.onSearchPressed,
      required this.textEditingController,
      required this.label,
      this.showIcon = true});

  static const _borderRadius = 40.0;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      onChanged: onChange,
      style: Theme.of(context).textTheme.bodyMedium,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 10,
        ),
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.ternary,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.secondary,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.errorColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.errorColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        suffixIcon: showIcon!
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                    onPressed: onSearchPressed,
                    icon: Assets.icons.saroSearch.svg(width: 40)),
              )
            : const SizedBox(),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
