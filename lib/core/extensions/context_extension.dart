import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/ui/colors/app_colors.dart';

extension BuildContextX on BuildContext {
  void showSnackBar(String text) => ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(this)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.white),
          ),
          elevation: 0,
          
          backgroundColor: AppColors.ternary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );

  Future<void> showBottomSheet(Widget body,
          {bool? isControlled = true}) async =>
      await showModalBottomSheet(
        isScrollControlled: isControlled ?? false,
        useRootNavigator: true,
        context: this,
        showDragHandle: true,
        builder: (buildContext) {
          return Padding(
            padding: EdgeInsets.only(
              right: 15,
              left: 15,
              top: 10,
              bottom: MediaQuery.of(buildContext).viewInsets.bottom,
            ),
            child: body,
          );
        },
      );

  void unfocus() => FocusScope.of(this).unfocus();

  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;

  TextStyle get headlineLarge => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get headlineSmall => Theme.of(this).textTheme.headlineSmall!;

  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;
  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;

  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;

  TextStyle get labelLarge => Theme.of(this).textTheme.labelLarge!;
  TextStyle get labelMedium => Theme.of(this).textTheme.labelMedium!;
  TextStyle get labelSmall => Theme.of(this).textTheme.labelSmall!;

  T? readOrNull<T>() {
    try {
      return read<T>();
    } on ProviderNotFoundException catch (_) {
      return null;
    }
  }
}
