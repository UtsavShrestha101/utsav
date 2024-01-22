// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:saro/core/models/peer.dart';

class PeerState {
  final List<Peer> peerList;
  final bool isLoading;
  final int page;
  final String? failureMsg;
  final bool hasReachedEnd;
  PeerState({
    this.isLoading = false,
    this.peerList = const [],
    this.page = 1,
    this.failureMsg,
    this.hasReachedEnd=false
  });

  PeerState copyWith({
    List<Peer>? peerList,
    bool? isLoading,
    int? page,
    String? failureMsg,
    bool? hasReachedEnd
  }) {
    return PeerState(
      isLoading: isLoading ?? this.isLoading,
      peerList: peerList ?? this.peerList,
      page: page ?? this.page,
      failureMsg: failureMsg,
      hasReachedEnd: hasReachedEnd??this.hasReachedEnd
    );
  }

  bool get isListEmpty => peerList.isEmpty && !isLoading;
}
