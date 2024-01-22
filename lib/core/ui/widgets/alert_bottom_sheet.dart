import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';

Future<dynamic> showAlertBottomSheet(
  String title,
  String subTitle,
  String buttonText,
  BuildContext context,
  VoidCallback callback,
) async {
  return await showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 40.0,
                    height: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 7.0),
                    decoration: BoxDecoration(
                      color: const Color(0xff606060),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  title,
                  style: context.titleMedium,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  subTitle,
                  style: context.bodyMedium,
                ),
              ),
              20.vSizedBox,
              SizedBox(
                width: double.infinity,
                height: 54,
                child: PrimaryButton(
                  title: buttonText,
                  onPressed: callback,
                  textStyle: context.titleLarge.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              10.vSizedBox,
              InkWell(
                onTap: context.pop,
                child: Text(
                  "cancel",
                  style: context.labelLarge,
                ),
              ),
              15.vSizedBox,
            ],
          ),
        ),
      );
    },
  );
}
