import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(initializationSettings);
    scheduleDailyNotification();
  }

  Future<void> scheduleDailyNotification() async {
    final tz.TZDateTime scheduledTime = tz.TZDateTime.now(tz.local)
        .add(Duration(seconds: 5)); // Test with a short delay

    await notificationsPlugin.zonedSchedule(
      0,
      'Test Notification Title',
      'This is a test notification body.',
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          channelDescription: 'Your channel description',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showNotification(
      {int id = 0, String? title, String? body}) async {
    await notificationsPlugin.show(
      id,
      title ?? 'Default Title',
      body ?? 'Default body',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          channelDescription: 'Your channel description',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  Future<void> checkNotificationPermission() async {
    final status = await Permission.notification.request();
    if (status.isGranted) {
      // Permission granted, you can proceed
    } else if (status.isDenied) {
      // Permission denied
    }
  }
}
