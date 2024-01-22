import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/features/post/select_post/cubit/select_post_cubit.dart';
import 'package:saro/resources/assets.gen.dart';

class SelectPostPage extends StatelessWidget {
  const SelectPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<SelectPostCubit>(),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Day",
              style: context.titleLarge,
            ),
            BlocListener<SelectPostCubit, SelectPostState>(
              listener: (context, state) {
                if (state is MediaPicked) {
                  context.goNamed(AppRouter.createPost, extra: state.file);
                }
                if (state is MediaPickedFailed) {
                  context.showSnackBar(state.message);
                }
              },
              child: Builder(
                builder: (context) => GestureDetector(
                  onTap: context.read<SelectPostCubit>().pickImage,
                  child: Column(
                    children: [
                      Assets.images.saroUfo.image(
                        height: 220,
                        width: 220,
                      ),
                      Text(
                        'Select photo or video to upload',
                        textAlign: TextAlign.center,
                        style: context.headlineMedium,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
