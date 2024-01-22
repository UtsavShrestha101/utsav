import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/features/home/home_page/cubit/notification_count/notification_count_cubit.dart';
import 'package:saro/features/notification/bloc/notification/notification_bloc.dart';
import 'package:saro/features/notification/bloc/notification/notification_event.dart';
import 'package:saro/features/notification/widgets/notification_list_view.dart';

class NotificationPage extends StatefulWidget {
  final NotificationCountCubit notificationCountCubit;
  const NotificationPage({super.key, required this.notificationCountCubit});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _userNotificationBloc = get<NotificationBloc>()
    ..add(
      LoadNotification(
        "user",
      ),
    )
    ..add(
      ViewNotification(),
    );

  final _transactionNotificationBloc = get<NotificationBloc>()
    ..add(
      LoadNotification(
        "transaction",
      ),
    );

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    widget.notificationCountCubit.refreshUserNotificationCount();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            7.5.vSizedBox,
            TabBar(
              indicatorColor: AppColors.primary,
              unselectedLabelColor: AppColors.black,
              indicatorWeight: 4,
              tabs: [
                Tab(
                  icon: Text(
                    "Squeaks",
                    style: context.titleLarge,
                  ),
                ),
                Tab(
                  icon: Text(
                    "Bones",
                    style: context.titleLarge,
                  ),
                )
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocProvider.value(
                    value: _userNotificationBloc,
                    child: NotificationListView(
                      notificationEvent: LoadNotification("user"),
                    ),
                  ),
                  BlocProvider.value(
                    value: _transactionNotificationBloc,
                    child: NotificationListView(
                      notificationEvent: LoadNotification("transaction"),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
