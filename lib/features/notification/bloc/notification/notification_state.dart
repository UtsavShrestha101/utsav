import 'package:saro/core/models/notification.dart';

class NotificationState {
  final List<UserNotification> notificationList;
  final bool isLoading;
  final int page;
  final String? failureMsg;
  final bool hasReachedEnd;

  NotificationState({
    this.isLoading = false,
    this.notificationList = const [],
    this.page = 1,
    this.failureMsg,
    this.hasReachedEnd = false,
  });

  NotificationState copyWith({
    List<UserNotification>? notificationList,
    bool? isLoading,
    int? page,
    String? failureMsg,
    bool? hasReachedEnd,
  }) {
    return NotificationState(
        isLoading: isLoading ?? this.isLoading,
        notificationList: notificationList ?? this.notificationList,
        page: page ?? this.page,
        failureMsg: failureMsg,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }

  bool get isListEmpty => notificationList.isEmpty && !isLoading;
}
