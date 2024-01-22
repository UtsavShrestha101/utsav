// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/features/home/home_page/cubit/my_post/my_post_cubit.dart';
import 'package:saro/features/home/home_page/cubit/my_post/my_post_state.dart';
import 'package:saro/features/post/post_page/bloc/post/post_event.dart';
import 'package:saro/resources/assets.gen.dart';

class MyPost extends StatelessWidget {
  const MyPost({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<MyPostCubit>()..loadPost(),
      child: BlocBuilder<MyPostCubit, MyPostState>(
        builder: (context, state) {
          if (state.myPost != null) {
            return InkWell(
              onTap: () async {
                context.pushNamed(
                  AppRouter.postPage,
                  extra: {
                    "postId": state.myPost!.id,
                    "postEvent": LoadAllPostList(),
                    "cubit": context.read<MyPostCubit>()
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 10,
                ),
                height: 130,
                child: Column(
                  children: [
                    Assets.icons.saroMood.svg(
                      height: 84,
                      width: 84,
                    ),
                    Text(
                      "My Day",
                      style: context.bodyLarge,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
