import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/date_time.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/room.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/saro_app_bar.dart';
import 'package:saro/core/ui/widgets/user_profile_avatar.dart';
import 'package:saro/features/dm/cubit/dm_bloc.dart';
import 'package:saro/features/dm/cubit/dm_events.dart';
import 'package:saro/features/dm/cubit/sticker_cubit/sticker_cubit.dart';
import 'package:saro/features/dm/widgets/bone_tile.dart';
import 'package:saro/features/dm/widgets/dm_bubble.dart';
import 'package:saro/features/dm/widgets/gif_tile.dart';
import 'package:saro/features/dm/widgets/sticker_tile.dart';
import 'package:saro/features/search/widgets/search_field.dart';
import 'package:saro/resources/assets.gen.dart';

class DmPage extends StatefulWidget {
  final String roomId;
  final RoomUser receiver;
  final List<String> userIds;

  const DmPage({
    super.key,
    required this.roomId,
    required this.receiver,
    required this.userIds,
  });

  @override
  State<DmPage> createState() => _DmPageState();
}

class _DmPageState extends State<DmPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  FocusNode focusNode = FocusNode();

  late final DmBloc _dmBloc;
  final StickerCubit stickerCubit = get<StickerCubit>()..getSticker();
  final _messageEditingController = TextEditingController();
  final _scrollController = ScrollController();
  String get message => _messageEditingController.text;
  VoidCallback get clearText => _messageEditingController.clear;

  void _scrollListener() {
    if (_scrollController.hasClients) {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.9) {
        _dmBloc.add(LoadDM(
          widget.receiver,
        ));
      }
    }
  }

  bool showMessageOption = false;
  final iconSize = 50.0;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _dmBloc = get<DmBloc>(param1: widget.roomId, param2: widget.userIds);
    _dmBloc.add(LoadDM(
      widget.receiver,
    ));
    _dmBloc.add(SubscribeToRoom());
    _dmBloc.add(ListenReadDM());
    _dmBloc.add(ListenTyping());
    _dmBloc.add(ReadDM());
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_scrollListener);
    });
    focusNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageEditingController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _dmBloc.close();
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (focusNode.hasFocus) {
      setState(() {
        showMessageOption = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _dmBloc,
      child: Scaffold(
        appBar: SaroAppBar(
          centerTitle: true,
          title: InkWell(
            onTap: () {
              context.push(
                AppRouter.userProfile,
                extra: widget.receiver.user.id,
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '@${widget.receiver.user.username}',
                  style: context.bodyLarge,
                ),
                if (widget.receiver.user.isIdentityVerified == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2.5,
                    ),
                    child: Assets.icons.saroVerify.svg(
                      height: 28,
                      width: 28,
                    ),
                  ),
              ],
            ),
          ),
        ),
        body: BlocConsumer<DmBloc, DmState>(
          listener: (context, state) {
            if (state.status == DmStatus.failed) {
              context.showSnackBar(state.errorMessage!);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: state.dmList.length,
                    itemBuilder: (context, index) {
                      final dmList = state.dmList[index];
                      return Column(
                        children: [
                          5.vSizedBox,
                          Text(
                            DateTime.fromMillisecondsSinceEpoch(
                                    dmList.first.createdAt)
                                .messageTimeStamp,
                            style: context.labelSmall,
                          ),
                          ListView.builder(
                              itemCount: dmList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final dm = dmList[index];
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      dm.isByUser(state.currentUserId)
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                  children: [
                                    if (!dm.isByUser(state.currentUserId))
                                      15.hSizedBox,
                                    Expanded(
                                      child: DmBubble(
                                        dm: dm,
                                        belongToCurrentUser:
                                            dm.isByUser(state.currentUserId),
                                      ),
                                    ),
                                    // if (dm.isByUser(state.currentUserId))
                                    state.roomUser!.unread == dm.index
                                        ? UserProfileAvatar(
                                            userAvatar:
                                                widget.receiver.user.avatar,
                                            imgHeight: 20,
                                            imgWidth: 20,
                                          )
                                        : 15.hSizedBox

                                    // Text(state.roomUser!.unread.toString())
                                  ],
                                );
                              })
                        ],
                      );
                    },
                  ),
                ),
                if (state.isTyping)
                  Lottie.asset(
                    "assets/animations/saro_typing.json",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SearchField(
                                focusNode: focusNode,
                                textEditingController:
                                    _messageEditingController,
                                label: 'say anything...',
                                showIcon: false,
                                onChange:
                                    context.read<DmBloc>().showTypingIndicator,
                              ),
                            ),
                            5.hSizedBox,
                            InkWell(
                              onTap: () {
                                context.unfocus();
                                setState(() {
                                  showMessageOption = !showMessageOption;
                                });
                              },
                              child: Assets.icons.saroHamburger.svg(
                                height: 50,
                                width: 50,
                              ),
                            ),
                            5.hSizedBox,
                            InkWell(
                              onTap: () async {
                                context
                                    .read<DmBloc>()
                                    .add(SendMessage(message));
                                clearText();
                              },
                              child: Assets.icons.saroSend.svg(
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ],
                        ),
                        if (Platform.isIOS) 12.5.vSizedBox
                      ],
                    ),
                  );
                }),
                if (showMessageOption)
                  Expanded(
                    child: Column(
                      children: [
                        TabBar(
                          indicatorColor: AppColors.primary,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(
                              icon: Row(
                                children: [
                                  Assets.icons.saroSticker.svg(
                                    height: iconSize,
                                    width: iconSize,
                                  ),
                                ],
                              ),
                            ),
                            Tab(
                              icon: Row(
                                children: [
                                  Assets.icons.saroGif.svg(
                                    height: iconSize,
                                    width: iconSize,
                                  ),
                                ],
                              ),
                            ),
                            Tab(
                              icon: Row(
                                children: [
                                  Assets.icons.saroFile.svg(
                                    height: iconSize,
                                    width: iconSize,
                                  ),
                                ],
                              ),
                            ),
                            Tab(
                              icon: Row(
                                children: [
                                  Assets.icons.saroBone.svg(
                                    height: iconSize,
                                    width: iconSize,
                                  ),
                                ],
                              ),
                            )
                          ],
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              const StickerTile(),
                              const GifTile(),
                              const Center(
                                child: Text(
                                  'File',
                                ),
                              ),
                              BoneTile(
                                receiverId: widget.receiver.user.id,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
