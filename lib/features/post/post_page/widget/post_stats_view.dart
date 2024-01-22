import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/models/post_detail.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/features/post/post_page/bloc/self_post_detail/self_post_detail_bloc.dart';
import 'package:saro/features/post/post_page/bloc/self_post_detail/self_post_detail_event.dart';
import 'package:saro/features/post/post_page/bloc/self_post_detail/self_post_detail_state.dart';
import 'package:saro/features/post/post_page/widget/post_stats_tile.dart';

class PostStatsListView extends StatefulWidget {
  final Widget emptyPlaceholder;
  final SelfPostDetailEvent selfPostEvent;
  const PostStatsListView({
    super.key,
    required this.selfPostEvent,
    required this.emptyPlaceholder,
  });

  @override
  State<PostStatsListView> createState() => _PostStatsListViewState();
}

class _PostStatsListViewState extends State<PostStatsListView> {
  late final _selfPostBloc = context.read<SelfPostDetailBloc>();
  final ScrollController _statsScrollController = ScrollController();

  void _statsScrollListener() {
    if (_statsScrollController.position.pixels >=
        _statsScrollController.position.maxScrollExtent * 0.9) {
      _selfPostBloc.add(widget.selfPostEvent);
    }
  }

  @override
  void initState() {
    _statsScrollController.addListener(_statsScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _statsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelfPostDetailBloc, SelfPostDetailState>(
      builder: (context, state) {
        if (state.error != null) {
          return Center(
            child: Text(
              state.error!,
            ),
          );
        } else if (state.isListEmpty) {
          return widget.emptyPlaceholder;
        } else {
          return ListView.builder(
            controller: _statsScrollController,
            itemCount: state.userData.length +
                (state.status == SelfPostDetailStatus.loading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < state.userData.length) {
                UserData user = state.userData[index];
                return PostStatsTile(
                  user: user,
                );
              } else {
                return const LoadingIndicator(
                  height: 75,
                  width: 75,
                );
              }
            },
          );
        }
      },
    );
  }
}
