import 'package:budgetbuddy/local_notification.dart';
import 'package:budgetbuddy/views/about/about_view.dart';
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

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String name = "Aditya";
  String mail = "drakewasinnocent@minor.com";

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

                            NotificationService().showNotification(
                                id: 0,
                                title: "Daily Tips",
                                body: "Check out today's tip",
                                payLoad: "dailyTips");

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
