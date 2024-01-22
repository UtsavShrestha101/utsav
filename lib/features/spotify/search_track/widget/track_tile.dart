import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/spotify_searched_track.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_event.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_bloc.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_state.dart';
import 'package:saro/features/spotify/widgets/play_pause_button.dart';
import 'package:saro/resources/assets.gen.dart';

class TrackTile extends StatelessWidget {
  const TrackTile({super.key, required this.track});

  final SpotifySearchedTrack track;
  final iconSize = 40.0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          if (track.previewUrl != null) {
            context.read<AudioBloc>().add(
                  AudioPlayEvent(
                    track: track,
                  ),
                );
          }
        },
        child: Row(
          children: [
            Assets.icons.saroSpotifyPlayList.svg(
              height: iconSize,
              width: iconSize,
            ),
            7.5.hSizedBox,
            Expanded(
              child: Text(
                track.name ?? "",
                style: context.bodyMedium,
                maxLines: 2,
              ),
            ),
            7.5.hSizedBox,
            track.previewUrl != null
                ? Row(
                    children: [
                      track.id == state.userProfileTrack!.id
                          ? Assets.icons.saroActiveStar.svg(
                              height: iconSize,
                              width: iconSize,
                            )
                          : GestureDetector(
                              onTap: () {
                                context
                                    .read<AudioBloc>()
                                    .add(FavoriteAudio(track));
                              },
                              child: Assets.icons.saroStar.svg(
                                height: iconSize,
                                width: iconSize,
                              ),
                            ),
                      PlayPauseButton(
                        spotifySearchedTrack: track,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
      );
    });
  }
}
