// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:saro/core/models/post_detail.dart';

enum SelfPostDetailStatus {
  initial,
  loading,
  success,
  failure,
}

class SelfPostDetailState {
  
  final List<UserData> userData;
  final String? error;
  final int page;
  final SelfPostDetailStatus status;

  SelfPostDetailState({
    this.userData = const [],
    this.error,
    this.status = SelfPostDetailStatus.initial,
    this.page = 1,
  });

  SelfPostDetailState copyWith({
    List<UserData>? userData,
    String? error,
    SelfPostDetailStatus? status,
    int? page,
    bool? isLoading,
  }) {
    return SelfPostDetailState(
      userData: userData ?? this.userData,
      error: error,
      status: status ?? this.status,
      page: page ?? this.page,
    );
  }

  bool get isListEmpty =>
      userData.isEmpty && !(status == SelfPostDetailStatus.loading);
}
