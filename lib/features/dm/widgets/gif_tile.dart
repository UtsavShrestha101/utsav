import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/core/ui/widgets/network_assets.dart';
import 'package:saro/features/dm/cubit/dm_bloc.dart';
import 'package:saro/features/dm/cubit/dm_events.dart';
import 'package:saro/features/dm/cubit/gif_cubit/gif_cubit.dart';
import 'package:saro/features/dm/cubit/gif_cubit/gif_state.dart';
import 'package:saro/features/search/widgets/search_field.dart';

class GifTile extends StatefulWidget {
  const GifTile({super.key});

  @override
  State<GifTile> createState() => _GifTileState();
}

class _GifTileState extends State<GifTile> {
  final _gifController = TextEditingController();

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<GifCubit>()..getGifData(),
      child: BlocBuilder<GifCubit, GifState>(builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                7.vSizedBox,
                SearchField(
                  label: 'Search anything...',
                  textEditingController: _gifController,
                  onSearchPressed: () {
                    context.read<GifCubit>().getGifData(
                          query: _gifController.text,
                        );
                  },
                ),
                7.vSizedBox,
                state.isLoading
                    ? const LoadingIndicator(
                        height: 200,
                        width: 200,
                      )
                    : state.gifUrls.isNotEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.25,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemCount: state.gifUrls.length,
                            itemBuilder: (context, index) {
                              return NetworkAssets(
                                key: ValueKey(
                                  state.gifUrls[index],
                                ),
                                fileKey: state.gifUrls[index],
                                imgHeight: 100,
                                imgWidth: 120,
                                onTap: () {
                                  context.read<DmBloc>().add(
                                        SendSourceImg(state.gifUrls[index]),
                                      );
                                },
                              );
                            },
                          )
                        : const LoadingIndicator(
                            height: 120,
                            width: 120,
                          ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
