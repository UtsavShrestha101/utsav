import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/features/spotify/spotify_widget/cubit/spotify_auth_cubit.dart';
import 'package:saro/features/spotify/spotify_widget/cubit/spotify_auth_state.dart';
import 'package:saro/resources/assets.gen.dart';

class SpotifyProfileBottomSheetView extends StatelessWidget {
  const SpotifyProfileBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => get<SpotifyAuthCubit>()..getSpotifyDetail(),
      child: BlocBuilder<SpotifyAuthCubit, SpotifyAuthState>(
        builder: (context, state) {
          return SizedBox(
              height: size.height * 0.15,
              width: size.width,
              child: state.failureMsg!.isNotEmpty
                  ? Center(
                      child: Text(state.failureMsg ?? ""),
                    )
                  : state.spotifyDetailStatus == SpotifyDetailStatus.success
                      ? ListTile(
                          leading: Assets.icons.saroSpotify.svg(width: 50),
                          title: Text(state.spotifyDetail?.displayName ?? ""),
                          trailing: GestureDetector(
                              onTap: () {
                                context.read<SpotifyAuthCubit>().logout();
                              },
                              child: Text(
                                "disconnect",
                                style: context.labelLarge
                                    .copyWith(color: AppColors.errorColor),
                              )),
                        )
                      : const Center(
                          child: LoadingIndicator(height: 35, width: 35)));
        },
      ),
    );
  }
}
