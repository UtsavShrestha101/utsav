import 'package:flutter/widgets.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/ui/colors/app_colors.dart';

class TextMessage extends StatelessWidget {
  final bool belongToCurrentUser;
  final String text;
  const TextMessage(
      {super.key, required this.belongToCurrentUser, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: belongToCurrentUser ? AppColors.secondary : AppColors.primary,
          borderRadius: BorderRadius.circular(16)),
      child: Text(
        text,
        style: context.bodyMedium,
      ),
    );
  }
}
