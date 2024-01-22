import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/models/dm.dart';
import 'package:saro/core/models/room.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/features/home/home_page/cubit/rooms/room_cubit.dart';
import 'package:saro/features/home/home_page/widgets/room_tile.dart';

class MyRooms extends StatefulWidget {
  const MyRooms({super.key});

  @override
  State<MyRooms> createState() => _MyRoomsState();
}

class _MyRoomsState extends State<MyRooms> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<RoomCubit>(),
      child: BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
        switch (state.status) {
          case RoomStatus.initial:
            return const SizedBox();

          case RoomStatus.loading:
            return const Center(child: CircularProgressIndicator.adaptive());

          case RoomStatus.failure:
            return Center(
              child: Text(state.failureMessage ?? ""),
            );
          case RoomStatus.loaded:
            if (state.rooms.isEmpty) {
              return Center(
                child: Text(
                  "No room available.",
                  style: context.labelSmall,
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.rooms.length +
                      (state.status == RoomStatus.loading ? 1 : 0),
                  controller: _scrollController
                    ..addListener(() {
                      if (_scrollController.position.pixels >=
                          _scrollController.position.maxScrollExtent * 0.9) {
                        context.read<RoomCubit>().loadMoreRooms();
                      }
                    }),
                  itemBuilder: (context, index) {
                    if (index < state.rooms.length) {
                      Room room = state.rooms[index];
                      Dm dm = room.latestMessage;
                      String roomId = room.id;
                      RoomUser receiver = room.members
                          .firstWhere((e) => e.user.id != state.userId);
                      RoomUser me = room.members
                          .firstWhere((e) => e.user.id == state.userId);
                      List<String> userIds = room.members
                          .map((user) => user.id.toString())
                          .toList();
                      return RoomTile(
                          belongToCurrentUser: dm.isByUser(state.userId),
                          room: state.rooms[index],
                          receiver: receiver,
                          isViewed: me.unread == 0 ? true : false,
                          unreadCount: me.unread!,
                          onTap: () {
                            context.push('/rooms/$roomId/dms', extra: {
                              "userIds": userIds,
                              "receiver": receiver
                            });
                          });
                    } else {
                      return const LoadingIndicator(
                        height: 75,
                        width: 75,
                      );
                    }
                  },
                ),
              );
            }
        }
      }),
    );
  }
}
