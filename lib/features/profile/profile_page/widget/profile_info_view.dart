import 'package:flutter/widgets.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';

class ProfileInfoView extends StatelessWidget {
  final String title;
  final String value;
  final Widget image;
  const ProfileInfoView(
      {super.key,
      required this.title,
      required this.value,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image,
        2.5.hSizedBox,
        Text(
          value,
        ),
        2.5.hSizedBox,
        Text(
          title,
          style: context.bodyMedium,
        ),
      ],
    );
  }
}
