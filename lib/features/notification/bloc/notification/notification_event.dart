abstract class NotificationEvent {}

final class LoadNotification extends NotificationEvent {
  final String type;
  final bool refreshList;
  LoadNotification(this.type, {this.refreshList = false});
}

final class ViewNotification extends NotificationEvent {}
