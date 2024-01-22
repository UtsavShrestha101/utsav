import 'package:saro/core/models/post.dart';

class FollowingsPostState {
  final List<Post> post;
  final bool isLoading;
  final int page;
  final String? failureMsg;
  final bool hasReachedEnd;
  final bool hasCreatedPost;

  FollowingsPostState({
    this.isLoading = false,
    this.post = const [],
    this.page = 1,
    this.failureMsg,
    this.hasReachedEnd = false,
    this.hasCreatedPost = false,
  });

  FollowingsPostState copyWith({
    List<Post>? post,
    bool? isLoading,
    int? page,
    String? failureMsg,
    bool? hasReachedEnd,
    bool? hasCreatedPost,
  }) {
    return FollowingsPostState(
      isLoading: isLoading ?? this.isLoading,
      post: post ?? this.post,
      page: page ?? this.page,
      failureMsg: failureMsg ?? this.failureMsg,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      hasCreatedPost: hasCreatedPost ?? this.hasCreatedPost,
    );
  }

  bool get isListEmpty => post.isEmpty && !isLoading && !hasCreatedPost;
}
