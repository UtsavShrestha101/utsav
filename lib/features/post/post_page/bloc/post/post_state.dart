import 'package:saro/core/models/post_detail.dart';

class PostState {
  final List<PostDetail> post;
  final bool isLoading;
  final int page;
  final String? failureMsg;

  PostState({
    this.isLoading = false,
    this.post = const [],
    this.page = 1,
    this.failureMsg,
  });

  PostState copyWith({
    List<PostDetail>? post,
    bool? isLoading,
    int? page,
    String? failureMsg,
  }) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      post: post ?? this.post,
      page: page ?? this.page,
      failureMsg: failureMsg ,
    );
  }

  bool get isListEmpty => post.isEmpty && !isLoading;
}
