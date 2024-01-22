import 'package:flutter/cupertino.dart';
import 'package:saro/core/ui/colors/app_colors.dart';

class CupertinoSwitchButton extends StatelessWidget {
  final Color? activeColor;
  final Color? trackColor;
  final Color? thumbColor;
  final bool? applyTheme;
  final Color? focusColor;
  final Color? onLabelColor;
  final Color? offLabelColor;
  final FocusNode? focusNode;
  final void Function(bool)? onFocusChange;
  final bool autofocus = false;
  final bool? value;
  final void Function(bool)? onChanged;
  const CupertinoSwitchButton(
      {super.key,
      this.activeColor,
      this.trackColor,
      this.thumbColor,
      this.applyTheme,
      this.focusColor,
      this.onLabelColor,
      this.offLabelColor,
      this.focusNode,
      this.onFocusChange,
      this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border.all(color: AppColors.primary.withOpacity(0.5), width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: SizedBox(
        width: 51,
        height: 31,
        child: CupertinoSwitch(
            thumbColor: thumbColor ?? AppColors.primary,
            trackColor: trackColor ?? AppColors.primary.withOpacity(0.3),
            activeColor: AppColors.primary,
            value: value ?? false,
            onChanged: onChanged),
      ),
    );
  }
}
