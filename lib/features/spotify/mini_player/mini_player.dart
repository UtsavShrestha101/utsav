import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_event.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_bloc.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_state.dart';
import 'package:saro/features/spotify/widgets/bottom_sheet_view.dart';
import 'package:saro/features/spotify/widgets/play_pause_button.dart';
import 'package:saro/resources/assets.gen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});
  final double _miniPlayerIconSize = 60;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Brightness brightness = Theme.of(context).brightness;
    return BlocConsumer<AudioBloc, AudioState>(listener: (context, state) {
      if (state.failureMsg.isNotEmpty) {
        context.showSnackBar(state.failureMsg);
      }
    }, builder: (context, state) {
      return state.status == AudioPlayerStatus.initial ||
              state.status == AudioPlayerStatus.stopped
          ? const SizedBox.shrink()
          : Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 2,
                vertical: 2,
              ),
              height: size.height * 0.11,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.ternary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.showBottomSheet(
                          SpotifyBottomSheetView(
                            audioBloc: context.read<AudioBloc>(),
                          ),
                          isControlled: true);
                    },
                    child: state.status == AudioPlayerStatus.playing
                        ? Lottie.asset(
                            "assets/animations/cd_play.json",
                            height: _miniPlayerIconSize,
                            width: _miniPlayerIconSize,
                          )
                        : Assets.icons.saroSpotifyPlayList.svg(
                            height: _miniPlayerIconSize,
                            width: _miniPlayerIconSize,
                          ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(state.track?.name ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: context.labelMedium),
                              3.vSizedBox,
                              Text(state.track?.artists?[0].name ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: context.labelSmall.copyWith(
                                    fontSize: 27,
                                  )),
                            ],
                          ),
                        ),
                        const PlayPauseButton(),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<AudioBloc>().add(AudioStopEvent());
                    },
                    icon: Assets.icons.saroCancel.svg(
                      width: 30,
                      colorFilter: ColorFilter.mode(
                        brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
