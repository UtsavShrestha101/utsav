import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/models/sticker.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/core/ui/widgets/network_assets.dart';
import 'package:saro/features/dm/cubit/dm_bloc.dart';
import 'package:saro/features/dm/cubit/dm_events.dart';
import 'package:saro/features/dm/cubit/sticker_cubit/sticker_cubit.dart';

class StickerTile extends StatelessWidget {
  const StickerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<StickerCubit>()..getSticker(),
      child: BlocBuilder<StickerCubit, StickerState>(
        builder: (context, state) {
          if (state is StickerFailure) {
            return Text(state.failureMsg);
          } else if (state is StickerLoaded) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.25,
              ),
              itemCount: state.stickersList.length,
              itemBuilder: (context, index) {
                Sticker sticker = state.stickersList[index];
                return NetworkAssets(
                  fileKey: sticker.url,
                  imgHeight: 100,
                  imgWidth: 100,
                  onTap: () {
                    context.read<DmBloc>().add(
                          SendSourceImg(
                            sticker.url,
                          ),
                        );
                  },
                );
              },
            );
          } else {
            return const LoadingIndicator(
              height: 150,
              width: 150,
            );
          }
        },
      ),
    );
  }
}
