import 'package:budgetbuddy/firebase_options.dart';
import 'package:budgetbuddy/local_notification.dart';
import 'package:budgetbuddy/views/home/home_view.dart';
import 'package:budgetbuddy/views/login/config.dart';
import 'package:budgetbuddy/views/login/welcome.dart';
import 'package:budgetbuddy/views/main_tabview/main_tab_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'common/color_extension.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('user');
  tz.initializeTimeZones();
  print("getting user");
  print(box.get('user'));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize the NotificationService
  NotificationService notificationService = NotificationService();
  await notificationService.initNotification();

  // Run the app
  runApp(MyApp(
      notificationService: notificationService)); // Pass the instance here
}

class MyApp extends StatelessWidget {
  final NotificationService notificationService;

  const MyApp({super.key, required this.notificationService});

  @override
  Widget build(BuildContext context) {
    // Check for notification permission
    notificationService.checkNotificationPermission();

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
