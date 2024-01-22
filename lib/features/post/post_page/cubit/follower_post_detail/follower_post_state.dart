// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:saro/core/models/post_detail.dart';

enum FollowingsPostDetailStatus {
  initial,
  loading,
  success,
  failure,
}

class FollowingsPostDetailState {
  final FollowingsPostDetailStatus status;
  final PostDetail post;
  final String? msg;

  FollowingsPostDetailState(
    this.post, {
    this.status = FollowingsPostDetailStatus.initial,
    this.msg,
  });

  FollowingsPostDetailState copyWith({
    FollowingsPostDetailStatus? status,
    PostDetail? post,
    String? msg,
  }) {
    return FollowingsPostDetailState(
      post ?? this.post,
      msg: msg,
      status: status ?? this.status,
    );
  }
}
