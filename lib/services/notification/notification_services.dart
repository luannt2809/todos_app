import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  static final NotificationServices _notificationServices =
      NotificationServices._internal();

  factory NotificationServices() {
    return _notificationServices;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationServices._internal();

  Future<void> initNotification() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_laucher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      int id, String title, String body, DateTime deadline) async {
    final currentTime = DateTime.now();

    if (deadline.isAfter(currentTime)) {
      final timeUtilDeadline = deadline.difference(currentTime);
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.now(tz.getLocation("Vietnam/Hanoi")).add(timeUtilDeadline),
          const NotificationDetails(
              android: AndroidNotificationDetails(
                "main_channel",
                "Main Channel",
                channelDescription: 'desc',
                importance: Importance.max,
                priority: Priority.max,
              ),
              iOS: DarwinNotificationDetails(
                sound: 'default.wav',
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              )),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }
}
