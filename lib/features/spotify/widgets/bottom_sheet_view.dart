import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_bloc.dart';
import 'package:saro/features/spotify/search_track/search_track_view.dart';
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_bloc/playlist_bloc.dart';
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_bloc/playlist_event.dart';
import 'package:saro/features/spotify/spotify_playlist/widgets/spotify_playlist_listview.dart';
import 'package:saro/resources/assets.gen.dart';

class SpotifyBottomSheetView extends StatefulWidget {
  final AudioBloc audioBloc;
  final SpotifyPlaylistBloc? spotifyPlaylistBloc;
  const SpotifyBottomSheetView(
      {super.key, required this.audioBloc, this.spotifyPlaylistBloc});

  @override
  State<SpotifyBottomSheetView> createState() => _SpotifyBottomSheetViewState();
}

class _SpotifyBottomSheetViewState extends State<SpotifyBottomSheetView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final SpotifyPlaylistBloc spotifyPlaylistBlocFromMiniPlayer =
      get<SpotifyPlaylistBloc>()..add(FetchPlaylistEvent());

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          height: size.height * 0.63,
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              25.vSizedBox,
              TabBar(
                indicatorColor: AppColors.primary,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    icon: Row(
                      children: [
                        Assets.icons.saroMusic
                            .svg(fit: BoxFit.contain, height: 40, width: 40),
                        12.5.hSizedBox,
                        Text(
                          "playlist",
                          style: context.labelLarge,
                        )
                      ],
                    ),
                  ),
                  Tab(
                    icon: Row(
                      children: [
                        Assets.icons.saroSearch
                            .svg(fit: BoxFit.contain, height: 40, width: 40),
                        12.5.hSizedBox,
                        Text(
                          "search",
                          style: context.labelLarge,
                        )
                      ],
                    ),
                  )
                ],
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: widget.audioBloc),
                        BlocProvider.value(
                          value: widget.spotifyPlaylistBloc ??
                              spotifyPlaylistBlocFromMiniPlayer,
                        ),
                      ],
                      child: const SpotifyPlaylistView(),
                    ),
                    BlocProvider.value(
                      value: widget.audioBloc,
                      child: const SearchTrackView(),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
