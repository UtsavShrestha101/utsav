part of 'dm_bloc.dart';

enum DmStatus { initial, loading, loaded, failed }

class DmState {
  const DmState({
    required this.currentUserId,
    this.status = DmStatus.initial,
    this.dms = const [],
    this.page = 1,
    this.errorMessage,
    this.hasReachedEnd = false,
    this.isTyping = false,
    this.roomUser,
  });

  final DmStatus status;
  final String currentUserId;
  final List<Dm> dms;
  final int page;
  final String? errorMessage;
  final bool hasReachedEnd;
  final bool isTyping;
  final RoomUser? roomUser;

  DmState copyWith({
    DmStatus? status,
    List<Dm>? dms,
    int? page,
    String? errorMessage,
    bool? hasReachedEnd,
    bool? isTyping,
    RoomUser? roomUser,
  }) {
    return DmState(
      currentUserId: currentUserId,
      status: status ?? this.status,
      dms: dms ?? this.dms,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      isTyping: isTyping ?? this.isTyping,
      roomUser: roomUser ?? this.roomUser,
    );
  }

  bool get isLastMessageSentByCurrentUser =>
      dms.lastOrNull?.userId == currentUserId;

  List<List<Dm>> get dmList {
    List<List<Dm>> groupedMessages = [];
    DateTime? currentGroupTime;

    for (int index = dms.length - 1; index >= 0; index--) {
      var message = dms[index].copyWith(index: index);
      if (currentGroupTime == null ||
          DateTime.fromMillisecondsSinceEpoch(message.createdAt)
                  .difference(currentGroupTime)
                  .inMinutes >=
              5) {
        currentGroupTime =
            DateTime.fromMillisecondsSinceEpoch(message.createdAt);
        groupedMessages.add([message]);
      } else {
        groupedMessages.last.add(message);
      }
    }
    return groupedMessages.reversed.toList();
  }
}
