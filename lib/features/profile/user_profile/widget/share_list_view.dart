import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/models/user_search_result.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/features/profile/user_profile/widget/share_list_tile.dart';
import 'package:saro/features/search/cubit/search_cubit.dart';
import 'package:saro/features/search/cubit/search_state.dart';
import 'package:saro/features/search/widgets/search_field.dart';

class ShareListView extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function(String) share;
  const ShareListView(
      {super.key, required this.textEditingController, required this.share});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocProvider(
        create: (buildContext) => get<SearchCubit>(),
        child: Builder(builder: (buildContext) {
          return Column(
            children: [
              SearchField(
                textEditingController: textEditingController,
                label: 'Search bestiez',
                onChange: buildContext.read<SearchCubit>().search,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    final metrics = notification.metrics;

                    if (metrics.extentAfter <= metrics.maxScrollExtent * 0.9) {
                      buildContext.read<SearchCubit>().loadMore();
                    }

                    return false;
                  },
                  child: BlocConsumer<SearchCubit, SearchState>(
                    listener: (buildContext, state) {
                      if (state.errorMessage != null) {
                        buildContext.showSnackBar(state.errorMessage!);
                      }
                    },
                    builder: (buildContext, state) {
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

                          return ShareTile(
                            userSearchResult: userSearchResult,
                            onTap: () {
                              buildContext.read<SearchCubit>().shareContent(
                                    userSearchResult.id,
                                  );
                              share(
                                userSearchResult.id,
                              );
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
    );
  }
}
