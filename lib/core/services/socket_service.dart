import 'package:injectable/injectable.dart';
import 'package:saro/core/flavor/flavor_config.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'database_service.dart';

@singleton
class SocketService {
  final LocalDatabaseService databaseService;

  Socket? socket;

  SocketService(this.databaseService);

  Socket get _instance => socket ??= io(
        FlavorConfig.values.socketUrl,
        OptionBuilder().setQuery({
          'token': databaseService.credentials!.accessToken
        }).setTransports(['websocket']).build(),
      );

  void listenToEvent({
    required String event,
    required void Function(dynamic data) listener,
  }) {
    _instance.on(event, listener);
  }

  void sendEvent({
    required String event,
    required Map<String, dynamic> data,
  }) {
    _instance.emit(event, data);
  }
}
