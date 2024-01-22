import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/models/spotify_searched_track.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_bloc.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_event.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_state.dart';
import 'package:saro/resources/assets.gen.dart';

class PlayPauseButton extends StatelessWidget {
  final SpotifySearchedTrack? spotifySearchedTrack;
  const PlayPauseButton({super.key, this.spotifySearchedTrack});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              if (spotifySearchedTrack != null &&
                  (state.status == AudioPlayerStatus.paused ||
                      state.status == AudioPlayerStatus.initial)) {
                context.read<AudioBloc>().add(
                      AudioPlayEvent(
                        track: spotifySearchedTrack,
                      ),
                    );
              } else if (state.status == AudioPlayerStatus.playing) {
                context.read<AudioBloc>().add(AudioPauseEvent());
              } else if (state.status == AudioPlayerStatus.paused) {
                context.read<AudioBloc>().add(AudioResumeEvent());
              } else if (state.status == AudioPlayerStatus.initial) {
                context.read<AudioBloc>().add(
                      AudioPlayEvent(),
                    );
              }
            },
            child: state.status == AudioPlayerStatus.playing
                ? Assets.icons.saroSpotifyPause.svg(
                    height: 60,
                    width: 60,
                  )
                : Assets.icons.saroSpotifyPlay.svg(
                    height: 60,
                    width: 60,
                  ),
          );
        });
      },
    );
  }
}
