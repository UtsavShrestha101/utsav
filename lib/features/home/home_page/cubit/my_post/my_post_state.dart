import 'package:saro/core/models/post_detail.dart';

class MyPostState {
  final PostDetail? myPost;
  final bool isLoading;
  final String? failureMsg;

  MyPostState({
    this.isLoading = false,
    this.myPost,
    this.failureMsg,
  });

  MyPostState copyWith({
    PostDetail? myPost,
    bool? isLoading,
    String? failureMsg,
  }) {
    return MyPostState(
      isLoading: isLoading ?? this.isLoading,
      myPost: myPost,
      failureMsg: failureMsg,
    );
  }
}
