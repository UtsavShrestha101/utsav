// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/features/home/home_page/cubit/notification_count/notification_count_cubit.dart';
import 'package:saro/resources/assets.gen.dart';
import 'package:badges/badges.dart' as badges;

class MyNotification extends StatelessWidget {
  const MyNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          get<NotificationCountCubit>()..refreshUserNotificationCount(),
      child: BlocBuilder<NotificationCountCubit, int>(
        builder: (context, state) {
          return InkWell(
            onTap: () {
              context.pushNamed(
                AppRouter.notification,
                extra: context.read<NotificationCountCubit>(),
              );
            },
            child: state != 0
                ? badges.Badge(
                    badgeContent: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        state <= 99 ? state.toString() : "99+",
                        style: context.labelSmall.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    position: badges.BadgePosition.topEnd(top: -6, end: -4),
                    child: Assets.icons.saroGreenTennisBall.svg(
                      width: 50,
                    ),
                  )
                : Assets.icons.saroGreenTennisBall.svg(
                    width: 50,
                  ),
          );
        },
      ),
    );
  }
}
