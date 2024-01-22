import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/models/room.dart';
import 'package:saro/core/repository/room_repository.dart';
part 'room_state.dart';

@injectable
class RoomCubit extends Cubit<RoomState> {
  RoomCubit(
    this._repository,
  ) : super(
          RoomState(
            _repository.currentUser!.id,
          ),
        );

  final RoomRepository _repository;

  StreamSubscription<Room>? roomSubscription;

  int _pageNumber = 1;

  @postConstruct
  void init() {
    _getRooms();
    _subscribeToRooms();
  }

  void loadMoreRooms() async {
    await _getRooms();
  }

  Future<void> _getRooms() async {
    try {
      if (state.hasReachedEnd) return;
      emit(state.copyWith(status: RoomStatus.loading));
      final rooms = await _repository.getRooms(page: _pageNumber);

      emit(state.copyWith(
        status: RoomStatus.loaded,
        rooms: [...state.rooms, ...rooms],
        hasReachedEnd: rooms.length < 10 ? true : false,
      ));

      _pageNumber++;
    } on NetworkException catch (e) {
      emit(state.copyWith(
          status: RoomStatus.failure, failureMessage: e.message));
    }
  }

  Future<void> _subscribeToRooms() async {
    roomSubscription = _repository.roomSubscription.listen(_updateRoomList);
    _repository.readMsgSubscription.listen(_changeStatus);
    
  }

  _changeStatus(Room roomData) {
    List<Room> rooms = List.from(state.rooms);
    Room targetRoom = rooms.firstWhere(
      (room) => room.id == roomData.id,
    );
    int index = rooms.indexOf(targetRoom);
    rooms.removeAt(index);
    rooms.insert(index, roomData);
    emit(
      state.copyWith(
        rooms: rooms,
      ),
    );
  }

  _updateRoomList(Room room) {
    final rooms = [room, ...state.rooms..removeWhere((e) => e.id == room.id)];
    emit(state.copyWith(rooms: rooms));
  }
}
