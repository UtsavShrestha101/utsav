import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/models/spotify_searched_track.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/features/search/widgets/search_field.dart';
import 'package:saro/features/spotify/search_track/cubit/search_track_cubit.dart';
import 'package:saro/features/spotify/search_track/cubit/search_track_state.dart';
import 'package:saro/features/spotify/search_track/widget/track_tile.dart';

class SearchTrackView extends StatefulWidget {
  const SearchTrackView({super.key});

  @override
  State<SearchTrackView> createState() => _SearchTrackViewState();
}

class _SearchTrackViewState extends State<SearchTrackView> {
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<SearchTrackCubit>(),
      child: Builder(builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Builder(builder: (context) {
              return Column(
                children: [
                  SearchField(
                    textEditingController: searchController,
                    label: 'Search anything...',
                    onChange: context.read<SearchTrackCubit>().search,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        final metrics = notification.metrics;

                        if (metrics.extentAfter <=
                            metrics.maxScrollExtent * 0.9) {
                          context.read<SearchTrackCubit>().loadMore();
                        }

                        return false;
                      },
                      child: BlocConsumer<SearchTrackCubit, SearchTrackState>(
                        listener: (context, state) {
                          if (state.errorMessage != null) {
                            context.showSnackBar(state.errorMessage!);
                          }
                        },
                        builder: (context, state) {
                          if (state.isSearchResultEmpty) {
                            return Text(
                              "We didn't find anything named ${state.query}",
                              textAlign: TextAlign.center,
                            );
                          }

                          if (!state.loadMore && state.isSearching) {
                            return const Align(
                                alignment: Alignment.topCenter,
                                child: LoadingIndicator(
                                  height: 100,
                                  width: 100,
                                ));
                          }

                          return ListView.builder(
                            itemCount: state.loadMore
                                ? state.result.length + 1
                                : state.result.length,
                            itemBuilder: (_, i) {
                              if (i == state.result.length) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: LoadingIndicator(
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                );
                              }

                              SpotifySearchedTrack trackSearchResult =
                                  state.result[i];

                              return TrackTile(
                                track: trackSearchResult,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      }),
    );
  }
}
