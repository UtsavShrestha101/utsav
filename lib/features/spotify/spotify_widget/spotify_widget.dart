import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/features/spotify/spotify_widget/cubit/spotify_auth_cubit.dart';
import 'package:saro/features/spotify/spotify_widget/cubit/spotify_auth_state.dart';
import 'package:saro/features/spotify/widgets/play_track_widget.dart';
import 'package:saro/resources/assets.gen.dart';

class SpotifyWidget extends StatelessWidget {
  const SpotifyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            get<SpotifyAuthCubit>()..isUserConnectedToSpotify(),
        child: BlocConsumer<SpotifyAuthCubit, SpotifyAuthState>(
          listener: (context, state) {
            if (state.spotifyLoginStatus == SpotifyLoginStatus.success) {
              context.showSnackBar("Spotify connected");
            } else if (state.spotifyLoginStatus == SpotifyLoginStatus.failure) {
              context.showSnackBar(state.failureMsg ?? "");
            }
          },
          builder: (context, state) {
            if (state.isUserAuthenticated ||
                state.spotifyLoginStatus == SpotifyLoginStatus.success) {
              return const PlayTrackWidget();
            } else {
              return GestureDetector(
                onTap: () async {
                  String loginUrl = context
                      .read<SpotifyAuthCubit>()
                      .getSpotifyLoginUrlWithUserId();
                  String authToken =
                      context.read<SpotifyAuthCubit>().getAccessToken();

                  context.push(
                    AppRouter.spotifyLoginPage,
                    extra: {
                      "url": loginUrl,
                      "authToken": authToken,
                      "cubit": context.read<SpotifyAuthCubit>()
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.icons.saroSpotify.svg(
                      height: 35,
                      width: 35,
                    ),
                    10.hSizedBox,
                    Text(
                      "connect Spotify",
                      style: context.bodyMedium,
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
