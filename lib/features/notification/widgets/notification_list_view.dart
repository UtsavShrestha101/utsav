import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/models/notification.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/features/notification/bloc/notification/notification_bloc.dart';
import 'package:saro/features/notification/bloc/notification/notification_event.dart';
import 'package:saro/features/notification/bloc/notification/notification_state.dart';
import 'package:saro/features/notification/widgets/notification_list_tile.dart';

class NotificationListView extends StatefulWidget {
  final NotificationEvent notificationEvent;
  const NotificationListView({
    super.key,
    required this.notificationEvent,
  });

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  late final NotificationBloc _notificationBloc =
      context.read<NotificationBloc>();

  final ScrollController _notificationScrollController = ScrollController();

  void _notificationScrollListener() {
    if (_notificationScrollController.position.pixels >=
        _notificationScrollController.position.maxScrollExtent * 0.9) {
      _notificationBloc.add(widget.notificationEvent);
    }
  }

  @override
  void initState() {
    _notificationScrollController.addListener(_notificationScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _notificationScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state.failureMsg != null) {
          return Center(
            child: Text(
              state.failureMsg!,
            ),
          );
        } else if (state.isListEmpty) {
          return const Center(
            child: Text(
              "Oops, Your list is empty.",
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return ListView.builder(
            controller: _notificationScrollController,
            itemCount:
                state.notificationList.length + (state.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < state.notificationList.length) {
                UserNotification userNotification =
                    state.notificationList[index];
                return NotificationListTile(
                  userNotification: userNotification,
                );
              } else {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: LoadingIndicator(
                      height: 125,
                      width: 125,
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
