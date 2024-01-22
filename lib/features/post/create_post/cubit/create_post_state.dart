part of 'create_post_cubit.dart';

enum CreatePostStatus { initial, creating, success, failure }

class CreatePostState extends Equatable {
  final CreatePostStatus status;
  final int? progress;
  final String? failureMessage;
  final bool bestieOnly;
  final String? message;
  final String? postId;

  const CreatePostState({
    this.bestieOnly = false,
    this.message,
    required this.status,
    this.progress,
    this.failureMessage,
    this.postId,
  });

  factory CreatePostState.initial() {
    return const CreatePostState(
      status: CreatePostStatus.initial,
    );
  }

  factory CreatePostState.creating() {
    return const CreatePostState(
      status: CreatePostStatus.creating,
    );
  }

  factory CreatePostState.success(String postId) {
    return  CreatePostState(
      status: CreatePostStatus.success,
      postId: postId
    );
  }

  factory CreatePostState.failure(String failureMessage) {
    return CreatePostState(
      status: CreatePostStatus.failure,
      failureMessage: failureMessage,
    );
  }

  CreatePostState copyWith({
    CreatePostStatus? status,
    int? progress,
    bool? bestieOnly,
    String? failureMessage,
    String? message,
  }) {
    return CreatePostState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      bestieOnly: bestieOnly ?? this.bestieOnly,
      failureMessage: failureMessage ?? this.failureMessage,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, progress, bestieOnly, failureMessage];
}
