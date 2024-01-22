import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_bloc.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_state.dart';
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_bloc/playlist_bloc.dart';
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_bloc/playlist_event.dart';
import 'package:saro/features/spotify/widgets/bottom_sheet_view.dart';
import 'package:saro/features/spotify/widgets/play_pause_button.dart';
import 'package:saro/resources/assets.gen.dart';

class PlayTrackWidget extends StatefulWidget {
  const PlayTrackWidget({super.key});

  @override
  State<PlayTrackWidget> createState() => _PlayTrackWidgetState();
}

class _PlayTrackWidgetState extends State<PlayTrackWidget> {
  final SpotifyPlaylistBloc _spotifyPlaylistBloc = get<SpotifyPlaylistBloc>()
    ..add(
      FetchPlaylistEvent(),
    );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _spotifyPlaylistBloc),
          BlocProvider.value(value: context.read<AudioBloc>()),
        ],
        child: Builder(builder: (context) {
          return BlocBuilder<AudioBloc, AudioState>(builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      context.showBottomSheet(
                        SpotifyBottomSheetView(
                          audioBloc: context.read<AudioBloc>(),
                          spotifyPlaylistBloc:
                              context.read<SpotifyPlaylistBloc>(),
                        ),
                        isControlled: true,
                      );
                    },
                    child: state.status == AudioPlayerStatus.playing
                        ? Lottie.asset(
                            "assets/animations/cd_play.json",
                            height: 60,
                            width: 60,
                          )
                        : Assets.icons.saroSpotifyPlayList.svg(
                            height: 60,
                            width: 60,
                          ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                      state.status == AudioPlayerStatus.initial
                          ? state.userProfileTrack?.name ?? ""
                          : state.track?.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: context.labelMedium),
                ),
                5.hSizedBox,
                const Expanded(
                  flex: 1,
                  child: PlayPauseButton(),
                )
              ],
            );
          });
        }));
  }
}
