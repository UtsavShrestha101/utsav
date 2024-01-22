import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/post_detail.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/action_list_tile.dart';
import 'package:saro/core/ui/widgets/network_assets.dart';
import 'package:saro/core/ui/widgets/saro_app_bar.dart';
import 'package:saro/features/home/home_page/cubit/my_post/my_post_cubit.dart';
import 'package:saro/features/post/post_page/bloc/self_post_detail/self_post_detail_bloc.dart';
import 'package:saro/features/post/post_page/bloc/self_post_detail/self_post_detail_event.dart';
import 'package:saro/features/post/post_page/bloc/self_post_detail/self_post_detail_state.dart';
import 'package:saro/features/post/post_page/widget/expandable_caption_widget.dart';
import 'package:saro/features/post/post_page/widget/post_stats_view.dart';
import 'package:saro/resources/assets.gen.dart';

class SelfPostDetailPage extends StatefulWidget {
  final PostDetail post;
  const SelfPostDetailPage({super.key, required this.post});

  @override
  State<SelfPostDetailPage> createState() => _SelfPostDetailPageState();
}

class _SelfPostDetailPageState extends State<SelfPostDetailPage>
    with SingleTickerProviderStateMixin {
  final _iconSize = 45.0;

  late TabController _tabController;

  late final _likeListBloc = get<SelfPostDetailBloc>(param1: widget.post.id)
    ..add(
      LoadLikesListEvent(),
    );

  late final _dislikeListBloc = get<SelfPostDetailBloc>(param1: widget.post.id)
    ..add(
      LoadHateListEvent(),
    );

  late final _lukersListBloc = get<SelfPostDetailBloc>(param1: widget.post.id)
    ..add(
      LoadLukersListEvent(),
    );

  late final _screenshotTakersListBloc =
      get<SelfPostDetailBloc>(param1: widget.post.id)
        ..add(
          LoadScreenshotTakersListEvent(),
        );

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => get<SelfPostDetailBloc>(param1: widget.post.id),
      child: BlocConsumer<SelfPostDetailBloc, SelfPostDetailState>(
          listener: (context, state) async {
        if (state.status == SelfPostDetailStatus.failure) {
          context.showSnackBar(state.error!);
        } else if (state.status == SelfPostDetailStatus.success) {
          final myPostCubit = context.readOrNull<MyPostCubit>();
          if (myPostCubit != null) {
            await context.read<MyPostCubit>().refreshPost();
          }
          if (context.mounted) {
            context.pop();
            context.pop();
            context.showSnackBar("Post deleted successfully");
          }
        }
      }, builder: (BuildContext context, SelfPostDetailState state) {
        return Scaffold(
          backgroundColor: AppColors.black.withOpacity(0.6),
          appBar: SaroAppBar(
            useDarkIcon: false,
            actions: [
              InkWell(
                onTap: () {
                  _showStatsBottomSheet(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Assets.icons.saroLurking.svg(
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ],
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              NetworkAssets(
                fileKey:
                    widget.post.isPremium ? widget.post.id : widget.post.url!,
                imgHeight: size.height,
                imgWidth: size.width,
                isPremiumContent: widget.post.isPremium,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  width: size.width,
                  // width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ExpandableCaptionWidget(
                              post: widget.post,
                              gotoProfilePage: false,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  void _showStatsBottomSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      builder: (builderContext) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: MediaQuery.of(builderContext).size.height * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                10.vSizedBox,
                TabBar(
                  isScrollable: true,
                  indicatorColor: AppColors.primary,
                  unselectedLabelColor: Colors.black,
                  tabAlignment: TabAlignment.start,
                  indicatorWeight: 4,
                  tabs: [
                    Tab(
                      icon: Text(
                        "Lukers",
                        style: context.bodyMedium,
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Loves",
                        style: context.bodyMedium,
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Haters",
                        style: context.bodyMedium,
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Screenshots",
                        style: context.bodyMedium,
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
                      BlocProvider.value(
                        value: _lukersListBloc,
                        child: PostStatsListView(
                          emptyPlaceholder: Center(
                            child: Column(
                              children: [
                                Assets.icons.saroPasswordHide.svg(
                                  height: 140,
                                  width: 140,
                                ),
                                Text(
                                  "No lukers",
                                  style: context.labelLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          selfPostEvent: LoadLukersListEvent(),
                        ),
                      ),
                      BlocProvider.value(
                        value: _likeListBloc,
                        child: PostStatsListView(
                          emptyPlaceholder: Center(
                            child: Column(
                              children: [
                                Assets.icons.saroPasswordView.svg(
                                  height: 140,
                                  width: 140,
                                ),
                                Text(
                                  "No loves",
                                  style: context.labelLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          selfPostEvent: LoadLikesListEvent(),
                        ),
                      ),
                      BlocProvider.value(
                        value: _dislikeListBloc,
                        child: PostStatsListView(
                          emptyPlaceholder: Center(
                            child: Column(
                              children: [
                                Assets.icons.saroHate.svg(
                                  height: 140,
                                  width: 140,
                                ),
                                Text(
                                  "No hates",
                                  style: context.labelLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          selfPostEvent: LoadHateListEvent(),
                        ),
                      ),
                      // Center(
                      //   child: Column(
                      //     children: [
                      // Assets.icons.saroScreenshot.svg(
                      //   height: 140,
                      //   width: 140,
                      // ),
                      // Text(
                      //   "No screenshot",
                      //   style: context.labelLarge,
                      //   textAlign: TextAlign.center,
                      // ),
                      //     ],
                      //   ),
                      // ),
                      BlocProvider.value(
                        value: _screenshotTakersListBloc,
                        child: PostStatsListView(
                          emptyPlaceholder: Center(
                            child: Column(
                              children: [
                                Assets.icons.saroScreenshot.svg(
                                  height: 140,
                                  width: 140,
                                ),
                                Text(
                                  "No screenshot",
                                  style: context.labelLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          selfPostEvent: LoadLikesListEvent(),
                        ),
                      ),
                    ],
                  ),
                ),
                ActionListTile(
                  onTap: () async {
                    context.read<SelfPostDetailBloc>().add(DeletePostEvent());
                  },
                  leading: Assets.icons.saroDelete.svg(
                    height: _iconSize,
                    width: _iconSize,
                  ),
                  title: "delete Post",
                ),
                5.vSizedBox,
                if (Platform.isIOS) 12.5.vSizedBox
              ],
            ),
          ),
        );
      },
    );
  }
}
