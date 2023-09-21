import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int idTB = 0;

  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('logo');

    var iOSInitializationSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) {});

    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSInitializationSettings);

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );

    final prefs = await SharedPreferences.getInstance();
    idTB = prefs.getInt('idTB') ?? 0;
    print(idTB);
  }

  Future<void> saveIdTB() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('idTB', idTB);
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails("channelId", "channelName",
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future scheduleNotification(
      {String? title,
      String? body,
      String? payload,
      required DateTime scheduledNotificationDateTime}) async {
    await notificationsPlugin.zonedSchedule(
        idTB,
        title,
        body,
        tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
        notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);

    idTB++;
    await saveIdTB();
  }
}
