import 'dart:async';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Timer? _timer;

  final List<String> budgetAdvices = [
    "Saving is like a relationship: it's all about commitment! 💰❤️",
    "Budgeting: because even your wallet deserves a little love! 💌",
    "Why did the budget go to therapy? It couldn't stop overspending! 😂",
    "If you think money can't buy happiness, try spending it wisely! 🎉💵",
    "A penny saved is a penny earned, but a funny advice is priceless! 😄",
    "Money talks, but all mine says is 'Goodbye!' 👋💸",
    "Why did the dollar break up with the quarter? It found a better sense of cents! 💔",
    "Remember, every time you splurge, a budget fairy loses its wings! 🧚‍♂️💔",
    "Budgeting is like a game of chess: you need to think ahead! ♟️💰",
    "Why did the dollar go to therapy? It had too many issues! 😩💵",
    "A balanced budget is like a balanced diet: essential for a healthy life! 🥗💸",
    "Why was the budget always calm? It knew how to manage stress! 😌💰",
    "If saving money was easy, everyone would be rich! 💪💵",
    "Why did the budget join a gym? To get in shape financially! 🏋️‍♂️💸",
    "If you want to be rich, start by budgeting your way to wealth! 🏆💰",
    "Why did the budget take a nap? It needed to recharge! 😴💵",
    "Money can't buy happiness, but it can buy a good budget! 🎉💰",
    "Why do budgets make great friends? They always keep it real! 🤝💵",
    "If I had a dollar for every time I saved, I'd be a millionaire! 💸💵",
    "Why did the budget get an award? It was outstanding in its field! 🏅💰",
    "A budget is like a map: it helps you find your way! 🗺️💸",
    "Why did the piggy bank apply for a job? It wanted to earn some interest! 🐷💼",
    "Don't let your budget be a mystery; solve it like a detective! 🕵️‍♀️🔍",
    "Every time you spend, remember: it's a choice, not a command! 🧭💰",
    "If only my bank account had a 'snooze' button! 😴💵",
    "Why did the budget fail its driving test? It couldn't stay within the lines! 🚦💸",
    "My financial planner is my best friend, even if it's just a spreadsheet! 📈🤓",
    "Why did the wallet feel sad? It lost its 'credit'! 😢💳",
    "Budgeting is like dieting: you have to stay disciplined to see results! 🥗💵",
    "Why don't budgets tell secrets? They can't keep track! 🤫💸",
    "If money talks, mine must be on mute! 🤐💰",
    "Every time I save, a unicorn gets its wings! 🦄💖",
    "Why did the budget break up with the credit card? Too much interest! 💔💳",
    "If spending money is a crime, I'm serving a life sentence! 🚔💵",
    "Why did the budget start a band? It wanted to rock its expenses! 🎸💸",
    "A budget is just a fancy word for a plan that keeps your money in check! 📊🕵️‍♂️",
    "If budgeting were a dance, I'd be the lead! 💃💵",
    "Why did the budget cross the road? To get to the other side of savings! 🛣️💰",
    "When life gives you lemons, make a budget! 🍋💵",
    "Why did the budget go on a diet? To shed those extra expenses! 🥗💸",
    "Saving money is a marathon, not a sprint! 🏃‍♂️💰",
    "Why do budgets love math? They always find a solution! ➕💵",
    "Every time I find a penny, an angel gets its wings! 😇💰",
    "Why did the budget break a leg? It wanted to make some 'cents'! 🎭💵",
    "If my money were a pet, it would be a runaway! 🐾💸",
    "Why did the budget get invited to parties? It knew how to save the day! 🎉💰",
    "When in doubt, budget it out! 🤔💵",
    "Why did the budget bring a pencil? To sketch out its future! ✏️💰",
    "If I had a dollar for every budgeting tip, I'd have... well, you get it! 😂💵",
    "Why do budgets love nature? They appreciate the beauty of balance! 🌳💸",
    "A budget is like a good friend: it tells you the truth! 🗣️💰",
    "Why did the budget go to art school? To learn how to draw the line! 🎨💵",
    "If my bank account had a personality, it would be introverted! 😶💰",
    "Why did the budget get a job? To support its family of expenses! 👨‍👩‍👧‍👦💵",
    "When budgeting, remember: a little goes a long way! 🌈💸",
    "Why did the budget take up gardening? To grow its savings! 🌱💰",
    "If money were a movie, mine would be a comedy! 🎬💵",
    "Why did the budget go hiking? To explore new financial heights! 🥾💰",
    "Every time I save, I add a chapter to my success story! 📖💵",
    "Why did the budget start a podcast? To share its wisdom! 🎙️💰",
    "If I could have one wish, it would be a full wallet! 🧞‍♂️💵",
    "Why did the budget always stay positive? It knew how to balance! ➕💰",
    "If spending were a rollercoaster, I'd be screaming! 🎢💵",
    "Why did the budget go to the beach? To catch some savings rays! 🌊💰",
    "Remember, budgeting is not a punishment; it's a privilege! 🎁💵",
    "Why did the budget take a selfie? To capture its spending habits! 📸💸",
    "If money were candy, mine would be on a diet! 🍬💰",
    "Why did the budget enroll in yoga? To find its center! 🧘‍♂️💵",
    "If budgeting were a color, it would be green! 🍀💰",
    "Why did the budget get a smartphone? To keep track of expenses on the go! 📱💵",
    "Every penny counts, especially when you're saving! 💸💰",
    "Why did the budget go to the concert? To rock its financial future! 🎶💵",
    "If my budget were a superhero, it would be Captain Savings! 🦸‍♂️💰",
    "Why did the budget get a makeover? It wanted to look fabulous! 💄💵",
    "Remember, every dollar saved is a dollar earned! 🤑💰",
    "Why did the budget throw a party? To celebrate smart spending! 🎉💵",
    "If my wallet had a theme song, it would be 'Can't Buy Me Love!' 🎶💰",
    "Why did the budget join a club? To meet other like-minded savers! 🤝💵",
    "When budgeting, think big, save bigger! 💭💰",
    "Why did the budget get a promotion? It exceeded expectations! 🏆💵",
    "If budgeting were a game, I'd play to win! 🎮💰",
    "Why did the budget love math class? It was all about the numbers! ➗💵",
    "Remember, every small step counts toward your financial goals! 👣💰",
  ];

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
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 6, 0); // 6 AM

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(
          days: 1)); // Schedule for the next day if time has passed
    }

    await notificationsPlugin.zonedSchedule(
      0,
      'Budget Advice',
      getRandomAdvice(),
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

  String getRandomAdvice() {
    final random = Random();
    return budgetAdvices[random.nextInt(budgetAdvices.length)];
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
