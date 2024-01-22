import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/extensions/list_extension.dart';
import 'package:saro/core/models/dm.dart';
import 'package:saro/core/models/room.dart';
import 'package:saro/core/repository/room_repository.dart';
import 'package:saro/features/dm/cubit/dm_events.dart';
part 'dm_state.dart';

@injectable
class DmBloc extends Bloc<DmEvent, DmState> {
  DmBloc(
      this._repository, @factoryParam this.roomId, @factoryParam this.userIds)
      : super(DmState(currentUserId: _repository.currentUser!.id)) {
    on<SubscribeToRoom>(_subscribeToRoom);
    on<ListenTyping>(_listenTyping);
    on<LoadDM>(_loadDM, transformer: droppable());
    on<SendMessage>((event, emit) => _sendMessage(event));
    on<SendSourceImg>((event, emit) => _sendSourceImg(event));
    on<ReadDM>(_readDM);
    on<ListenReadDM>(_listenReadDm);
    on<DisposeListeners>(_disposeListener);
  }

  final RoomRepository _repository;
  final String roomId;
  final List<String> userIds;
  StreamSubscription<Room>? roomSubscription;

  Future<void> _loadDM(LoadDM event, Emitter<DmState> emit) async {
    if (state.hasReachedEnd) return;
    try {
      emit(
        state.copyWith(
          status: DmStatus.loading,
          roomUser: event.roomUser,
        ),
      );

      final dms = await _repository.getDms(roomId, state.page);

      emit(
        state.copyWith(
          status: DmStatus.loaded,
          dms: [...state.dms, ...dms],
          page: state.page + 1,
          hasReachedEnd: dms.length < 10,
        ),
      );
    } on NetworkException catch (e) {
      emit(state.copyWith(
        status: DmStatus.failed,
        errorMessage: e.message,
      ));
    }
  }

  void showTypingIndicator(String data) async {
    final data = {
      "userId": _repository.currentUser!.id,
      "roomId": roomId,
      "username": _repository.currentUser!.username,
      "users": userIds,
    };
    _repository.sendTypingIndicator(data);
  }

  Future<void> _subscribeToRoom(
      SubscribeToRoom event, Emitter<DmState> emit) async {
    await emit.forEach(_repository.roomSubscription, onData: (room) {
      RoomUser receiver = room.members
          .firstWhere((e) => e.user.id != _repository.currentUser!.id);
      List<Dm> dmList = List.from(state.dms);
      if (roomId == room.id) {
        Dm? existingDm = dmList.firstWhereOrNull(
            (dm) => dm.mediaGroupId == room.latestMessage.mediaGroupId);
        if (room.latestMessage.mediaGroupId != null && existingDm != null) {
          existingDm.medias?.addAll(room.latestMessage.medias ?? []);
        } else {
          dmList.insert(0, room.latestMessage);
        }
      }
      add(ReadDM());
      return state.copyWith(
        dms: dmList,
        roomUser: receiver,
      );
    });
  }

  setMessageSeen() {}

  startTyping() {}

  Future<void> _sendMessage(SendMessage event) async {
    await _repository.sendMessage(
      type: "TEXT",
      roomId: roomId,
      message: event.message,
    );
  }

  Future<void> _sendSourceImg(SendSourceImg event) async {
    await _repository.sendMessage(
      type: "SOURCE_IMG",
      roomId: roomId,
      sourceImg: event.url,
    );
  }

  Future<void> _readDM(ReadDM event, Emitter<DmState> emit) async {
    await _repository.readMsg(
      roomId,
    );
  }

  Future<void> _listenTyping(ListenTyping event, Emitter<DmState> emit) async {
    await emit.forEach(_repository.typingListenSubscription,
        onData: (isTyping) {
      return state.copyWith(
        isTyping: isTyping,
      );
    });
  }

  Future<void> _disposeListener(
      DisposeListeners event, Emitter<DmState> emit) async {}


  Future<void> _listenReadDm(ListenReadDM event, Emitter<DmState> emit) async {
    await emit.forEach(_repository.readMsgSubscription, onData: (room) {
      RoomUser receiver = room.members
          .firstWhere((e) => e.user.id != _repository.currentUser!.id);
      return state.copyWith(
        roomUser: receiver,
      );
    });
  }

  @override
  Future<void> close() async {
    await super.close();
  }
}
