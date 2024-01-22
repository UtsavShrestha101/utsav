import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/models/peer.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/features/profile/profile_page/bloc/peer/peer_bloc.dart';
import 'package:saro/features/profile/profile_page/bloc/peer/peer_event.dart';
import 'package:saro/features/profile/profile_page/bloc/peer/peer_state.dart';
import 'package:saro/features/profile/profile_page/widget/peer_list_tile.dart';

class PeerListView extends StatefulWidget {
  final PeerEvent peerEvent;
  const PeerListView({super.key, required this.peerEvent});

  @override
  State<PeerListView> createState() => _PeerListViewState();
}

class _PeerListViewState extends State<PeerListView> {
  late final PeerBloc _peerBloc = context.read<PeerBloc>();
  final ScrollController _notificationScrollController = ScrollController();

  void _notificationScrollListener() {
    if (_notificationScrollController.position.pixels >=
        _notificationScrollController.position.maxScrollExtent * 0.9) {
      _peerBloc.add(widget.peerEvent);
    }
  }

  @override
  void initState() {
    _notificationScrollController.addListener(_notificationScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _notificationScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeerBloc, PeerState>(
      builder: (context, state) {
        if (state.failureMsg != null) {
          return Center(
            child: Text(
              state.failureMsg!,
            ),
          );
        } else if (state.isListEmpty) {
          return const Center(
            child: Text(
              "Oops, Your Bestiez list is empty.",
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            controller: _notificationScrollController,
            itemCount: state.peerList.length + (state.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < state.peerList.length) {
                Peer lukerData = state.peerList[index];
                return PeerListTile(
                  peer: lukerData,
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
