import 'package:budgetbuddy/common/color_extension.dart';
import 'package:budgetbuddy/firebase_options.dart';
import 'package:budgetbuddy/local_notification.dart';
import 'package:budgetbuddy/views/login/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  tz.initializeTimeZones();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  NotificationService notificationService = NotificationService();
  await notificationService.initNotification();

  // Initialize WorkManager
  Workmanager().initialize(callbackDispatcher);

  // Register a periodic task to send notifications
  Workmanager().registerPeriodicTask(
    "1",
    "tips_notifications",
    frequency: const Duration(hours: 1), // Change the frequency as needed
  );

  runApp(MyApp(notificationService: notificationService));
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Task: $task");
    NotificationService notificationService = NotificationService();
    await notificationService.initNotification();
    await notificationService.showNotification(
      title: 'Budget Advice',
      body: notificationService.getRandomAdvice(),
    );
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  final NotificationService notificationService;

  const MyApp({super.key, required this.notificationService});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Budget Buddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
        colorScheme: ColorScheme.fromSeed(
            seedColor: TColor.primary,
            background: TColor.gray80,
            primary: TColor.primary,
            primaryContainer: TColor.gray60,
            secondary: TColor.secondary),
        useMaterial3: false,
      ),
      home: const WelcomeView(),
    );
  }
}
