import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/models/notification.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/features/notification/bloc/notification/notification_bloc.dart';
import 'package:saro/features/notification/bloc/notification/notification_event.dart';
import 'package:saro/features/notification/bloc/notification/notification_state.dart';
import 'package:saro/features/wallet/widget/activity_tile.dart';

class ActivityView extends StatelessWidget {
  final NotificationBloc notificationBloc;
  const ActivityView({super.key, required this.notificationBloc});

  loadMoreData() {
    notificationBloc.add(
      LoadNotification(
        "transaction",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: notificationBloc,
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state.failureMsg != null) {
            return Center(
              child: Text(
                state.failureMsg!,
              ),
            );
          } else if (state.isListEmpty) {
            return Center(
              child: Text(
                "No transaction found.",
                style: context.labelSmall,
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  loadMoreData();
                  return true;
                }
                return false;
              },
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      state.notificationList.length + (state.isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < state.notificationList.length) {
                      UserNotification userNotification =
                          state.notificationList[index];
                      return ActivityTile(
                        isReceived:
                            userNotification.type == NotificationType.CREDIT,
                        notification: userNotification,
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
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
