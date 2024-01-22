import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/features/profile/profile_page/bloc/peer/peer_bloc.dart';
import 'package:saro/features/profile/profile_page/bloc/peer/peer_event.dart';
import 'package:saro/features/profile/profile_page/cubit/profile_cubit.dart';
import 'package:saro/features/profile/profile_page/widget/peer_list_view.dart';
import 'package:saro/features/profile/profile_page/widget/profile_tile.dart';
import 'package:saro/resources/assets.gen.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _profileCubit = get<ProfileCubit>()..refreshUserData();
  final _bestiezBloc = get<PeerBloc>()
    ..add(
      LoadBestiezList(),
    );
  final _lukerBloc = get<PeerBloc>()
    ..add(
      LoadLurkersList(),
    );

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    _bestiezBloc.add(
      LoadBestiezList(refreshList: true),
    );
    _lukerBloc.add(
      LoadLurkersList(refreshList: true),
    );
    _profileCubit.refreshUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: NestedScrollView(
            scrollDirection: Axis.vertical,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  BlocProvider.value(
                    value: _profileCubit,
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return SliverAppBar(
                          elevation: 0.0,
                          pinned: true,
                          floating: true,
                          expandedHeight:
                              state.user.isIdentityVerified ? 420 : 440,
                          surfaceTintColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          flexibleSpace: LayoutBuilder(builder:
                              (BuildContext context,
                                  BoxConstraints constraints) {
                            return const Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned.fill(
                                  child: FlexibleSpaceBar(
                                      collapseMode: CollapseMode.pin,
                                      background: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                        ),
                                        child: ProfileTile(),
                                      )),
                                ),
                              ],
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ],
            body: Column(
              children: [
                TabBar(
                  indicatorColor: AppColors.primary,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      icon: Row(
                        children: [
                          Assets.icons.saroUsername.svg(),
                          2.5.hSizedBox,
                          Text(
                            "Bestiez",
                            style: context.labelLarge,
                          )
                        ],
                      ),
                    ),
                    Tab(
                      icon: Row(
                        children: [
                          Assets.icons.saroLurking.svg(),
                          2.5.hSizedBox,
                          Text(
                            "Lurking",
                            style: context.labelLarge,
                          )
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
                      BlocProvider.value(
                        value: _bestiezBloc,
                        child: PeerListView(
                          peerEvent: LoadBestiezList(),
                        ),
                      ),
                      BlocProvider.value(
                        value: _lukerBloc,
                        child: PeerListView(
                          peerEvent: LoadLurkersList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
