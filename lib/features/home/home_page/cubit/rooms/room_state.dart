part of 'room_cubit.dart';

enum RoomStatus { initial, loading, loaded, failure }

class RoomState
//  extends Equatable
{
  final String userId;
  final RoomStatus status;
  final List<Room> rooms;
  final String? failureMessage;
  final bool hasReachedEnd;

  const RoomState(
    this.userId, {
    this.status = RoomStatus.initial,
    this.rooms = const [],
    this.failureMessage,
    this.hasReachedEnd = false,
  });

  RoomState copyWith(
      {RoomStatus? status,
      List<Room>? rooms,
      String? failureMessage,
      bool? hasReachedEnd}) {
    return RoomState(userId,
        status: status ?? this.status,
        rooms: rooms ?? this.rooms,
        failureMessage: failureMessage ?? this.failureMessage,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }

  // @override
  // List<Object?> get props => [userId, status, rooms, failureMessage];
}
