import 'package:saro/core/models/room.dart';

sealed class DmEvent {}

final class SubscribeToRoom extends DmEvent {}

final class ListenReadDM extends DmEvent {}


final class LoadDM extends DmEvent {
  final RoomUser roomUser;

  LoadDM(this.roomUser);
}

final class ListenTyping extends DmEvent {}

final class ReadDM extends DmEvent {}


final class DisposeListeners extends DmEvent {}


final class SendMessage extends DmEvent {
  final String message;

  SendMessage(this.message);
}



final class SendSourceImg extends DmEvent {
  final String url;
  SendSourceImg(this.url);
}
