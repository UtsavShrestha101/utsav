import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/models/user_search_result.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/features/search/cubit/search_cubit.dart';
import 'package:saro/features/search/cubit/search_state.dart';
import 'package:saro/features/search/widgets/user_search_result_tile.dart';

import 'widgets/search_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<SearchCubit>(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Builder(builder: (context) {
            return Column(
              children: [
                SearchField(
                  textEditingController: searchController,
                  label: 'Search anything...',
                  onChange: context.read<SearchCubit>().search,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      final metrics = notification.metrics;

                      if (metrics.extentAfter <=
                          metrics.maxScrollExtent * 0.9) {
                        context.read<SearchCubit>().loadMore();
                      }

                      return false;
                    },
                    child: BlocConsumer<SearchCubit, SearchState>(
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

                            UserSearchResult userSearchResult = state.result[i];

                            return UserSearchResultTile(
                              userSearchResult: userSearchResult,
                              onTap: () {
                                if (userSearchResult.isFollowing) {
                                  context
                                      .read<SearchCubit>()
                                      .unFollowUser(userSearchResult.id);
                                } else {
                                  context
                                      .read<SearchCubit>()
                                      .followUser(userSearchResult.id);
                                }
                              },
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
      ),
    );
  }
}
