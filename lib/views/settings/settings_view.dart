import 'dart:math';

import 'package:budgetbuddy/local_notification.dart';
import 'package:budgetbuddy/views/about/about_view.dart';
import 'package:budgetbuddy/views/app_guide/app_guide_view.dart';
import 'package:budgetbuddy/views/key_features/key_features.dart';
import 'package:budgetbuddy/views/login/config.dart';
import 'package:budgetbuddy/views/login/welcome.dart';
import 'package:budgetbuddy/views/main_tab/main_tab_view.dart';
import 'package:budgetbuddy/views/stacks/stacks_used_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../common/color_extension.dart';
import '../../common_widget/icon_item_row.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:permission_handler/permission_handler.dart";

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String name = "Aditya";
  String mail = "drakewasinnocent@minor.com";

  final List<String> dailyTipsEnabledMessages = [
    "Great news! Daily budgeting tips are now enabled! 📅💡",
    "You've successfully enabled daily tips to boost your budgeting skills! 🚀💰",
    "Daily tips notifications are on! Get ready for some awesome advice! 📲✨",
    "Your daily budgeting tips are now at your fingertips! Stay tuned! 👌💵",
    "Daily tips have been activated! Let’s make budgeting fun and easy! 🎉💡",
    "You've opted in for daily tips! Get ready for financial wisdom every day! 📆💰",
    "Daily budgeting tips are here! You're one step closer to financial success! 🏆💵",
    "Congrats! Daily tips notifications are enabled for your budgeting journey! 🥳📊",
    "Your daily tips are ready to roll! Enjoy new budgeting insights each day! 📈💰",
    "Get ready! Daily budgeting tips are now enabled to help you save smarter! 💪💡",
    "Daily tips are now part of your budgeting routine! Let’s get started! 🚀💵",
    "You've enabled daily budgeting tips! Enjoy fresh insights every day! 🌟💰",
    "Daily tips notifications are live! Elevate your budgeting game! 🆙💡",
    "Welcome aboard! Daily tips for better budgeting are now active! 🙌📅",
    "Your daily tips notifications are now on! Prepare for budgeting brilliance! 💖💰",
    "Exciting news! Daily budgeting tips are enabled for you! Stay tuned! 🎊💵",
    "You've activated daily tips! Get ready to enhance your financial knowledge! 📚💡",
    "Daily tips notifications are now part of your routine! Let's budget smart! 🧠💰",
    "You're all set! Daily budgeting tips will help you every day! 🗓️✨",
    "Your budgeting journey just got better! Daily tips notifications are enabled! 🛤️💵",
    "Daily tips are officially enabled! Enjoy your path to financial literacy! 🚶‍♂️💡",
  ];

  void checkUser() async {
    var box = await Hive.openBox("user");
    setState(() {
      name = box.get("name");
      isTrue = box.get("dailyTips") ?? true;
      isSecurity = box.get("security") ?? false;
      mail = box.get("email") ?? "drakewasinnocent@minor.com";
    });

    print(box.get("security"));
  }

  void setDailyTips(isActive) async {
    var box = await Hive.openBox("user");
    box.put("dailyTips", isActive);

    print("set data: $isActive");
  }

  void setSecurity(isSecurity) async {
    var box = await Hive.openBox("user");
    box.put("authenticated", false);
    box.put("security", isSecurity);
  }

  bool isTrue = false;
  bool isSecurity = false;

  void checkNotificationPermission() async {
    final random = Random();
    var tips = dailyTipsEnabledMessages[
        random.nextInt(dailyTipsEnabledMessages.length)];

    PermissionStatus status = await Permission.notification.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      // Show custom dialog to explain the importance of notifications
      await Permission.notification.request().then((value) {
        if (value.isGranted) {
          NotificationService()
              .showNotification(id: 0, title: "Daily Tips", body: "$tips");
        }
      });
    } else if (status.isGranted) {
      NotificationService()
          .showNotification(id: 0, title: "Daily Tips", body: "$tips");
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset("assets/img/back.png",
                            width: 25, height: 25, color: TColor.gray30))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Settings",
                      style: TextStyle(color: TColor.gray30, fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/u1.png",
                  width: 70,
                  height: 70,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  mail,
                  style: TextStyle(
                      color: TColor.gray30,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () async {
                var box = await Hive.openBox("user");
                var subBox = await Hive.openBox("subscription");
                var highestBox = await Hive.openBox("highest");
                var lowestBox = await Hive.openBox("lowest");
                var totalSpentt = await Hive.openBox("totalSpent");

                box.deleteFromDisk();
                subBox.deleteFromDisk();
                highestBox.deleteFromDisk();
                lowestBox.deleteFromDisk();
                totalSpentt.deleteFromDisk();

                Get.offAll(() => WelcomeView(),
                    transition: Transition.fade,
                    duration: Duration(milliseconds: 500));
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: TColor.border.withOpacity(0.15),
                  ),
                  color: TColor.gray60.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Log out",
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 8),
                    child: Text(
                      "General",
                      style: TextStyle(
                          color: TColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TColor.border.withOpacity(0.1),
                      ),
                      color: TColor.gray60.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        IconItemSwitchRow(
                          title: "Security",
                          icon: "assets/img/security.png",
                          value: isSecurity,
                          didChange: (newVal) {
                            setState(() {
                              isSecurity = newVal;
                            });
                            setSecurity(newVal);
                          },
                        ),
                        IconItemSwitchRow(
                          title: "Daily Tips",
                          icon: "assets/img/icloud.png",
                          value: isTrue,
                          didChange: (newVal) {
                            setState(() {
                              isTrue = newVal;
                            });

                            if (newVal) {
                              checkNotificationPermission();
                            }

                            setDailyTips(newVal);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 8),
                    child: Text(
                      "Developer",
                      style: TextStyle(
                          color: TColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TColor.border.withOpacity(0.1),
                      ),
                      color: TColor.gray60.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => AboutUsView(),
                                transition: Transition.rightToLeftWithFade,
                                duration: const Duration(milliseconds: 500));
                          },
                          child: IconItemRow(
                            title: "About Us",
                            icon: "assets/img/app_icon.png",
                            value: "About",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => StacksUsedView(),
                                transition: Transition.rightToLeftWithFade,
                                duration: const Duration(milliseconds: 500));
                          },
                          child: IconItemRow(
                            title: "Stacks Used",
                            icon: "assets/img/light_theme.png",
                            value: "Stacks",
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            Get.to(() => KeyFeaturesView(),
                                transition: Transition.rightToLeftWithFade,
                                duration: const Duration(milliseconds: 500))
                          },
                          child: IconItemRow(
                            title: "Key Features",
                            icon: "assets/img/font.png",
                            value: "Features",
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            Get.to(() => AppGuideView(),
                                transition: Transition.rightToLeftWithFade,
                                duration: const Duration(milliseconds: 500))
                          },
                          child: IconItemRow(
                            title: "App Guide",
                            icon: "assets/img/guide.png",
                            value: "Guide",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 8),
                    child: Text(
                      "Source Code",
                      style: TextStyle(
                          color: TColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TColor.border.withOpacity(0.1),
                      ),
                      color: TColor.gray60.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            _redirectToGithub();
                          },
                          child: const IconItemRow(
                            title: "Github",
                            icon: "assets/img/github.png",
                            value: "Check Github Repo",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: media.height * 0.1,
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  _redirectToGithub() {
    var url = Uri.parse("https://github.com/adiyadav123/budget_buddy_");
    launchUrl(url);
  }
}
