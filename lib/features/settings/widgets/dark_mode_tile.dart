import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/app/theme_cubit/theme_cubit.dart';
import 'package:saro/app/theme_cubit/theme_state.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/cupertino_switch_button.dart';

class DarkModeTile extends StatelessWidget {
  const DarkModeTile({
    super.key,
    this.leading,
    required this.title,
    this.onTap,
  });

  final Widget? leading;

  final VoidCallback? onTap;

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          leading: leading,
          title: Text(title, style: context.labelLarge),
          onTap: onTap,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CupertinoSwitchButton(
                value: state is DarkTheme,
                thumbColor:
                    state is LightTheme ? AppColors.primary : AppColors.white,
                onChanged: (bool value) {
                  context.read<ThemeCubit>().toggleAppThemeState(value);
                }),
          ),
        );
      },
    );
  }
}
