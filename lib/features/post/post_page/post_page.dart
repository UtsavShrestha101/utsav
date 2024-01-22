import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/features/home/home_page/cubit/my_post/my_post_cubit.dart';
import 'package:saro/features/post/post_page/bloc/post/post_bloc.dart';
import 'package:saro/features/post/post_page/bloc/post/post_event.dart';
import 'package:saro/features/post/post_page/bloc/post/post_state.dart';
import 'package:saro/core/models/post_detail.dart';
import 'package:saro/features/post/post_page/widget/followings_post_detail_view.dart';
import 'package:saro/features/post/post_page/widget/self_post_detail_page.dart';

class PostPage extends StatefulWidget {
  final String postId;
  final PostEvent postEvent;
  final MyPostCubit? cubit;
  const PostPage({
    super.key,
    required this.postId,
    required this.postEvent,
    required this.cubit,
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late final PostBloc _postBloc = get<PostBloc>(param1: widget.postId)
    ..add(widget.postEvent);

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      if (_pageController.position.pixels ==
          _pageController.position.maxScrollExtent) {
        _postBloc.add(widget.postEvent);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _postBloc,
        ),
        if (widget.cubit != null)
          BlocProvider.value(
            value: widget.cubit!,
          )
      ],
      child: Scaffold(
        body: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if (state.failureMsg != null) {
              context.pop();
              context.showSnackBar(state.failureMsg!);
            }
          },
          builder: (context, state) {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: state.post.length,
              itemBuilder: (context, index) {
                PostDetail post = state.post[index];
                return post.selfPost == true
                    ? SelfPostDetailPage(post: post)
                    : FollowingsPostDetailView(post: post);
              },
            );
          },
        ),
      ),
    );
  }
}
