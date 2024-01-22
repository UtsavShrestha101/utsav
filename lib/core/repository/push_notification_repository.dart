import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/base/base_repository.dart';

@lazySingleton
class PushNotificationRepository extends BaseRepository {
  PushNotificationRepository(super.dio, super.database);

  static const _sendToken = '/push-notification/token';

  Future<void> sendFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await makeDioRequest<void>(
      () async {
        final data = {
          "fcmToken": token,
        };
        await dio.post(
          _sendToken,
          data: data,
        );
      },
    );
  }
}
