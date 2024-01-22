sealed class PeerEvent {}

final class LoadBestiezList extends PeerEvent {
  final bool refreshList;

  LoadBestiezList({this.refreshList = false});
}

final class LoadLurkersList extends PeerEvent {
   final bool refreshList;

  LoadLurkersList({this.refreshList = false});
}
