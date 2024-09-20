import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Timer? _timer;

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
    await checkNotificationPermission();
    await checkExactAlarmNotificationPermission();
    await scheduleDailyNotification();
  }

  Future<void> scheduleDailyNotification() async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledTime =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 15, 43); // 4 PM

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(
          days: 1)); // Schedule for the next day if time has passed
    }

    await notificationsPlugin.zonedSchedule(
      0,
      'Daily Reminder',
      'This is your reminder notification.',
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
      matchDateTimeComponents:
          DateTimeComponents.time, // Ensures it repeats daily at the same time
    );
  }

  Future<void> scheduleNotificationEvery10Seconds() async {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      await showNotification(
          title: 'Test Notification',
          body: 'This notification shows every 10 seconds.');
    });
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
      // Permission granted, proceed
    } else if (status.isDenied) {
      // Permission denied
    }
  }

  Future<void> checkExactAlarmNotificationPermission() async {
    final status = await Permission.scheduleExactAlarm.request();
    if (status.isGranted) {
      // Permission granted, proceed
    } else if (status.isDenied) {
      // Permission denied
    }
  }
}
