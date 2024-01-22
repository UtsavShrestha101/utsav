import 'package:flutter/material.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/utils/form_validators.dart';
import 'package:saro/features/home/home_page/widgets/my_notification.dart';
import 'package:saro/features/home/home_page/widgets/my_rooms.dart';
import 'package:saro/features/home/home_page/widgets/post_tile.dart';
import 'package:saro/features/home/home_page/widgets/verify_user_tile.dart';
import 'package:saro/resources/assets.gen.dart';

class HomePage extends StatelessWidget with FormValidators {
  HomePage({super.key});

  final _formKey = GlobalKey<FormState>();
  bool get isFormValid => _formKey.currentState!.validate();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Assets.images.saroWord.image(width: 100),
                    const MyNotification(),
                  ],
                ),
              ),
              10.vSizedBox,
              PostTile(),
              10.vSizedBox,
              const MyRooms()
            ],
          ),
        ),
      ),
      floatingActionButton: const VerifyUserTile(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
