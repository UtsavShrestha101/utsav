import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/models/post.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/core/ui/widgets/user_profile_avatar.dart';
import 'package:saro/features/home/home_page/bloc/followings_post/followings_post_bloc.dart';
import 'package:saro/features/home/home_page/bloc/followings_post/followings_post_event.dart';
import 'package:saro/features/home/home_page/bloc/followings_post/followings_post_state.dart';
import 'package:saro/features/home/home_page/widgets/my_post.dart';
import 'package:saro/features/post/post_page/bloc/post/post_event.dart';
import 'package:saro/resources/assets.gen.dart';

class PostTile extends StatelessWidget {
  PostTile({super.key});

  final FollowingsPostBloc _followingsPostBloc = get<FollowingsPostBloc>();

  void loadMoreData() {
    _followingsPostBloc.add(LoadFollowingsPostList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _followingsPostBloc..add(LoadFollowingsPostList()),
      child: BlocBuilder<FollowingsPostBloc, FollowingsPostState>(
        builder: (context, state) {
          return state.isListEmpty
              // && !state.hasCreatedPost
              ? const SizedBox()
              : SizedBox(
                  height: 126,
                  width: MediaQuery.of(context).size.width,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                        loadMoreData();
                        return true;
                      }
                      return false;
                    },
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          state.post.length + 1 + (state.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const MyPost();
                        } else if (index < state.post.length + 1) {
                          Post post = state.post[index - 1];

                          return InkWell(
                            onTap: () {
                              context.pushNamed(
                                AppRouter.postPage,
                                extra: {
                                  "postId": post.id,
                                  "postEvent": LoadOthersPostList(),
                                },
                              );
                            },
                            child: Container(
                              width: 95,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Column(
                                children: [
                                  post.viewed
                                      ? UserProfileAvatar(
                                          userAvatar: post.user.avatar,
                                          imgHeight: 84,
                                          imgWidth: 84,
                                        )
                                      : Assets.icons.saroMood.svg(
                                          height: 84,
                                          width: 84,
                                        ),
                                  Text(
                                    "@${post.user.username}",
                                    style: context.bodyLarge.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return state.hasReachedEnd
                              ? const SizedBox()
                              : const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: LoadingIndicator(
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                );
                        }
                      },
                    ),
                  ),
                );
        },
      ),
    );
  }
}
