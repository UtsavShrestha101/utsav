import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/firebase_options.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  PushNotificationService.display(message);
}

@singleton
class PushNotificationService {
  @PostConstruct(preResolve: true)
  Future<void> initialize() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: "Basic_channel",
          channelName: "Basic notification",
          channelDescription: "Channel Desc1",
          ledColor: AppColors.primary,
          enableLights: true,
          enableVibration: true,
          playSound: true,
          importance: NotificationImportance.High,
          soundSource: "resource://raw/notification_sound",
          channelShowBadge: true,
        ),
      ],
    );
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      criticalAlert: true,
      provisional: true,
    );

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(handleBackgroundMessage);
  }

  static void display(RemoteMessage message) async {
    int id = Random().nextInt(1000);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: "Basic_channel",
        title: message.notification!.title,
        body: message.notification!.body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}
