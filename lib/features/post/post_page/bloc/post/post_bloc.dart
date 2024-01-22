import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/post_detail.dart';
import 'package:saro/core/repository/post_repository.dart';
import 'package:saro/features/post/post_page/bloc/post/post_event.dart';
import 'package:saro/features/post/post_page/bloc/post/post_state.dart';

@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;
  final String postId;

  PostBloc(this._postRepository, @factoryParam this.postId)
      : super(PostState()) {
    on<LoadOthersPostList>(loadPostList, transformer: droppable());
    on<LoadAllPostList>(allPostList, transformer: droppable());
  }

  Future<void> loadPostList(
    LoadOthersPostList event,
    Emitter<PostState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          failureMsg: null,
        ),
      );
      List<PostDetail> postList = await _postRepository.getFollowingsPostList(
        state.page,
        postId,
      );

      emit(
        state.copyWith(
          isLoading: false,
          post: [
            ...state.post,
            ...postList,
          ],
          page: state.page + 1,
        ),
      );
    } on NetworkException catch (e) {
      emit(state.copyWith(
        isLoading: false,
        failureMsg: e.message,
      ));
    }
  }

  Future<void> allPostList(
    LoadAllPostList event,
    Emitter<PostState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          failureMsg: null,
        ),
      );
      List<PostDetail> postList = await _postRepository.getAllPostList(
        state.page,
        postId,
      );

      emit(
        state.copyWith(
          isLoading: false,
          post: [
            ...state.post,
            ...postList,
          ],
          page: state.page + 1,
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
