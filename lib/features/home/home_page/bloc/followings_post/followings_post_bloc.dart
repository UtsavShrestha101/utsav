import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/post.dart';
import 'package:saro/core/models/post_detail.dart';
import 'package:saro/core/repository/post_repository.dart';
import 'package:saro/features/home/home_page/bloc/followings_post/followings_post_event.dart';
import 'package:saro/features/home/home_page/bloc/followings_post/followings_post_state.dart';

@injectable
class FollowingsPostBloc
    extends Bloc<FollowingsPostEvent, FollowingsPostState> {
  final PostRepository _postRepository;

  FollowingsPostBloc(this._postRepository) : super(FollowingsPostState()) {
    on<LoadFollowingsPostList>(loadFollowingsPostList,
        transformer: droppable());
  }

  Future<void> loadFollowingsPostList(
    LoadFollowingsPostList event,
    Emitter<FollowingsPostState> emit,
  ) async {
    try {
      if (state.hasReachedEnd) return;
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
      List<Post> postList = await _postRepository.getFollowingsPost(
        state.page,
      );
      PostDetail? myPost = await _postRepository.myPost();

      emit(
        state.copyWith(
          isLoading: false,
          post: [
            ...state.post,
            ...postList,
          ],
          page: state.page + 1,
          hasReachedEnd: postList.length < 10 ? true : false,
          hasCreatedPost: myPost != null ? true : false,
        ),
      );
    } on NetworkException catch (e) {
      emit(state.copyWith(
        isLoading: false,
        failureMsg: e.message,
      ));
    }
  }
}
