import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/notification.dart';
import 'package:saro/core/repository/user_repository.dart';
import 'package:saro/features/notification/bloc/notification/notification_event.dart';
import 'package:saro/features/notification/bloc/notification/notification_state.dart';

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final UserRepository _userRepository;

  NotificationBloc(this._userRepository) : super(NotificationState()) {
    on<LoadNotification>(loadNotification, transformer: droppable());
    on<ViewNotification>(viewNotification);
  }

  Future<void> loadNotification(
      LoadNotification event, Emitter<NotificationState> emit) async {
    try {
      if (!event.refreshList) {
        if (state.hasReachedEnd) return;
      }
      emit(
        state.copyWith(
          isLoading: true,
          failureMsg: null,
          page: event.refreshList ? 1 : state.page,
        ),
      );
      List<UserNotification> notification =
          await _userRepository.notificationList(
        event.type,
        state.page,
      );

      emit(
        state.copyWith(
          isLoading: false,
          notificationList: event.refreshList
              ? [...notification]
              : [
                  ...state.notificationList,
                  ...notification,
                ],
          page: state.page + 1,
          hasReachedEnd: notification.length < 10 ? true : false,
        ),
      );
    } on NetworkException catch (e) {
      emit(state.copyWith(
        isLoading: false,
        failureMsg: e.message,
      ));
    }
  }

  Future<void> viewNotification(
      ViewNotification event, Emitter<NotificationState> emit) async {
    await _userRepository.viewNotification();
  }
}
