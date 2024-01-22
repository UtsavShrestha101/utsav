// ignore_for_file: unused_field

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/post_detail.dart';
import 'package:saro/core/repository/post_repository.dart';
import 'package:saro/core/repository/room_repository.dart';
import 'package:saro/core/repository/user_repository.dart';
import 'package:saro/features/post/post_page/cubit/follower_post_detail/follower_post_state.dart';

@injectable
class FollowingsPostDetailCubit extends Cubit<FollowingsPostDetailState> {
  final PostDetail post;
  final PostRepository _postRepository;
  final UserRepository _userRepository;
  final RoomRepository _roomRepository;

  FollowingsPostDetailCubit(
    this._postRepository,
    @factoryParam this.post,
    this._userRepository,
    this._roomRepository,
  ) : super(FollowingsPostDetailState(post));

  Future<void> reportPost(String reportMsg) async {
    try {
      emit(state.copyWith(
        status: FollowingsPostDetailStatus.loading,
        msg: null,
      ));
      await _postRepository.reportPost(state.post.id, reportMsg);
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: FollowingsPostDetailStatus.failure,
          msg: e.message,
        ),
      );
    }
  }

  Future<void> premiumFollow() async {
    try {
      emit(
        state.copyWith(
          msg: null,
          status: FollowingsPostDetailStatus.loading,
        ),
      );
      await _userRepository.premiumfollowUser(
        state.post.user!.id,
      );
      await loadPost();
      emit(
        state.copyWith(
          status: FollowingsPostDetailStatus.success,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: FollowingsPostDetailStatus.failure,
          msg: e.message,
        ),
      );
    }
  }

  Future<void> likePost() async {
    bool isDisliked = state.post.isDisliked!;
    try {
      emit(
        state.copyWith(
          post: state.post.copyWith(
            isLiked: true,
            isDisliked: false,
          ),
          msg: null,
          status: FollowingsPostDetailStatus.loading,
        ),
      );
      await _postRepository.likePost(state.post.id);
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: FollowingsPostDetailStatus.failure,
          post: state.post.copyWith(
            isLiked: false,
            isDisliked: isDisliked,
          ),
          msg: e.message,
        ),
      );
    }
  }

  Future<void> screenshotPost() async {
    await _postRepository.screenshotPost(state.post.id);
  }

  Future<void> unlikePost() async {
    try {
      emit(
        state.copyWith(
          post: state.post.copyWith(isLiked: false),
          msg: null,
          status: FollowingsPostDetailStatus.loading,
        ),
      );
      await _postRepository.unlikePost(state.post.id);
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: FollowingsPostDetailStatus.failure,
          post: state.post.copyWith(isLiked: true),
          msg: e.message,
        ),
      );
    }
  }

  Future<void> dislikePost() async {
    bool isLiked = state.post.isLiked!;
    try {
      emit(
        state.copyWith(
          post: state.post.copyWith(
            isDisliked: true,
            isLiked: false,
          ),
          status: FollowingsPostDetailStatus.loading,
          msg: null,
        ),
      );
      await _postRepository.dislikePost(state.post.id);
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: FollowingsPostDetailStatus.failure,
          post: state.post.copyWith(
            isDisliked: false,
            isLiked: isLiked,
          ),
          msg: e.message,
        ),
      );
    }
  }

  Future<void> undislikePost() async {
    try {
      emit(
        state.copyWith(
          post: state.post.copyWith(isDisliked: false),
          status: FollowingsPostDetailStatus.loading,
          msg: null,
        ),
      );
      await _postRepository.undislikePost(state.post.id);
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: FollowingsPostDetailStatus.failure,
          post: state.post.copyWith(isDisliked: true),
          msg: e.message,
        ),
      );
    }
  }

  Future<void> commentPost(String comment) async {
    try {
      emit(
        state.copyWith(
          msg: null,
          status: FollowingsPostDetailStatus.loading,
        ),
      );
      await _roomRepository.sendMessage(
        type: "REPLY_POST",
        postId: state.post.id,
        userId: state.post.user!.id,
        message: comment,
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: FollowingsPostDetailStatus.failure,
          msg: e.message,
        ),
      );
    }
  }

  Future<void> postView() async {
    if (!post.visible!) return;
    try {
      emit(
        state.copyWith(
          status: FollowingsPostDetailStatus.loading,
          msg: null,
        ),
      );

      await _postRepository.viewPost(
        state.post.id,
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: FollowingsPostDetailStatus.failure,
          msg: e.message,
        ),
      );
    }
  }

  Future<void> loadPost() async {
    if (post.isPremium) {
      PostDetail premiumPost = await _postRepository.getSinglePost(post.id);
      emit(
        state.copyWith(
          post: premiumPost,
        ),
      );
    }
  }

  Future<void> sharePost(String userId) async {
    try {
      await _roomRepository.sendMessage(
        type: "FORWARD_POST",
        userId: userId,
        postId: post.id,
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: FollowingsPostDetailStatus.failure,
          msg: e.message,
        ),
      );
    }
  }
}
