import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:saro/core/base/base_repository.dart';
import 'package:saro/core/constants/socket_events.dart';
import 'package:saro/core/models/dm.dart';
import 'package:saro/core/models/room.dart';
import 'package:saro/core/models/sticker.dart';
import 'package:saro/core/services/socket_service.dart';

@lazySingleton
class RoomRepository extends BaseRepository {
  RoomRepository(super.dio, super.database, this.socket);

  SocketService socket;

  static const _rooms = '/rooms';
  static String _dms(String roomId) => '/rooms/$roomId/dms';
  static String _singleRoom(String roomId) => '/rooms/$roomId';
  static String _readMsg(
    String roomId,
  ) =>
      '/rooms/$roomId/dms/read';
  static const _sendDms = '/rooms/dms';
  static const _sticker = "/stickers";

  final _streamController = StreamController<Room>.broadcast();
  Stream<Room> get roomSubscription => _streamController.stream;
  final _readMsgStreamController = StreamController<Room>.broadcast();

  Stream<Room> get readMsgSubscription => _readMsgStreamController.stream;

  final _typingListenStreamController = StreamController<bool>.broadcast();
  Stream<bool> get typingListenSubscription =>
      _typingListenStreamController.stream;

  Timer? _debounceTimer;

  @postConstruct
  void listenToRoom() async {
    socket.listenToEvent(
        event: SocketEvents.dmIncoming,
        listener: (data) {
          _streamController.sink.add(Room.fromJson(data));
        });
    socket.listenToEvent(
        event: SocketEvents.mediaIncoming,
        listener: (data) {
          _streamController.sink.add(Room.fromJson(data));
        });
    socket.listenToEvent(
        event: SocketEvents.dmRead,
        listener: (data) {
          _readMsgStreamController.sink.add(Room.fromJson(data));
        });
    socket.listenToEvent(
        event: SocketEvents.typingListen,
        listener: (data) {
          if (data["userId"] != database.currentUser!.id) {
            _typingListenStreamController.sink.add(true);
            if (_debounceTimer?.isActive ?? false) {
              _debounceTimer!.cancel();
            }
            _debounceTimer = Timer(const Duration(seconds: 1), () {
              _typingListenStreamController.sink.add(false);
            });
          }
        });
  }

  Future<List<Room>> getRooms({int page = 1}) async {
    return makeDioRequest<List<Room>>(() async {
      final response =
          await dio.get(_rooms, queryParameters: {"page": page, "limit": 10});
      return (response.data['result'] as List)
          .map((e) => Room.fromJson(e))
          .toList();
    });
  }

  Future<Room> getSingleRooms(String roomId) async {
    return makeDioRequest<Room>(() async {
      final response = await dio.get(
        _singleRoom(roomId),
      );
      return Room.fromJson(response.data);
    });
  }

  Future<List<Dm>> getDms(String roomId, int page) async {
    return makeDioRequest<List<Dm>>(() async {
      final params = {"page": page, "limit": limit};

      final response = await dio.get(_dms(roomId), queryParameters: params);

      return (response.data['result'] as List)
          .map((e) => Dm.fromJson(e))
          .toList();
    });
  }

  Future<Dm> sendMessage({
    required String type,
    String? message,
    String? sourceImg,
    String? profileId,
    String? postId,
    String? dmId,
    String? roomId,
    String? userId,
  }) async {
    return makeDioRequest<Dm>(() async {
      final data = {
        "type": type,
        "text": message,
        "dmId": dmId,
        "postId": postId,
        "profileId": profileId,
        "sourceImg": sourceImg,
      };

      final queryPara = {
        "roomId": roomId,
        "userId": userId,
      };
      queryPara.removeWhere((key, value) => value == null);

      final response = await dio.post(
        _sendDms,
        data: data,
        queryParameters: queryPara,
      );
      return Dm.fromJson(response.data);
    });
  }

  Future<void> readMsg(
    String roomId,
  ) async {
    return makeDioRequest<void>(() async {
      await dio.patch(_readMsg(roomId));
    });
  }

  Future<List<Sticker>> getSticker() async {
    return makeDioRequest<List<Sticker>>(() async {
      final response = await dio.get(_sticker);
      return (response.data['result'] as List)
          .map((e) => Sticker.fromJson(e))
          .toList();
    });
  }

  void sendTypingIndicator(Map<String, dynamic> data) {
    socket.sendEvent(event: SocketEvents.typingEmit, data: data);
  }

  @disposeMethod
  dispose() {
    _streamController.close();
    _readMsgStreamController.close();
    _typingListenStreamController.close();
  }
}
