import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateTimeX on DateTime {
  String get hrMin => DateFormat('h:mm a').format(toLocal());
  String get dayMonYear => DateFormat('dd MMM , y').format(toLocal());
  String get mmYY => DateFormat('MM/yyyy').format(toLocal());
  String get relativeTime => timeago.format(toLocal());
  String get messageTimeStamp {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    DateTime today = DateTime(now.year, now.month, now.day);

    if (toLocal().year == yesterday.year &&
        toLocal().month == yesterday.month &&
        toLocal().day == yesterday.day) {
      return 'YESTERDAY AT ${DateFormat('H:mm').format(toLocal())}';
    } else if (toLocal().year == today.year &&
        toLocal().month == today.month &&
        toLocal().day == today.day) {
      return 'TODAY AT ${DateFormat('H:mm').format(toLocal())}';
    } else {
      return DateFormat('MMM d \'AT\' H:mm').format(toLocal());
    }
  }
}
