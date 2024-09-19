import 'package:budgetbuddy/common_widget/stack_row.dart';
import 'package:budgetbuddy/views/login/config.dart';
import 'package:budgetbuddy/views/login/welcome.dart';
import 'package:budgetbuddy/views/main_tab/main_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../common/color_extension.dart';
import '../../common_widget/icon_item_row.dart';
import 'package:url_launcher/url_launcher.dart';

class StacksUsedView extends StatefulWidget {
  const StacksUsedView({super.key});

  @override
  State<StacksUsedView> createState() => _StacksUsedViewState();
}

class _StacksUsedViewState extends State<StacksUsedView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          children: [
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
                      "Stacks Used",
                      style: TextStyle(color: TColor.gray30, fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
            Image.asset(
              "assets/img/stacks.png",
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 8),
                        child: Text(
                          "Frontend",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: TColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
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
                    child: const Column(
                      children: [
                        StackRow(
                          title: "Flutter",
                          value: "Flutter",
                          about:
                              "Used for building the cross-platform mobile application with a rich user interface.",
                          icon: "assets/img/flutter.png",
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        StackRow(
                          title: "Dart",
                          value: "Flutter",
                          about:
                              "Used for building the cross-platform mobile application with a rich user interface.",
                          icon: "assets/img/dart.png",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 8),
                        child: Text(
                          "Backend",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: TColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
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
                    child: const Column(
                      children: [
                        StackRow(
                          title: "Firebase",
                          value: "Firebase",
                          about:
                              "Integrated for user authentication, database storage, and real-time data syncing.",
                          icon: "assets/img/firebase.png",
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        StackRow(
                          title: "Hive",
                          value: "Hive",
                          about:
                              "Lightweight NoSQL database for local storage of user data and preferences.",
                          icon: "assets/img/hive.png",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 8),
                        child: Text(
                          "State Management",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: TColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
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
                    child: const Column(
                      children: [
                        StackRow(
                          title: "GetX",
                          value: "GetX",
                          about:
                              "Used for state management, dependency injection, and navigation.",
                          icon: "assets/img/flutter.png",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 8),
                        child: Text(
                          "APIs & Integrations",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: TColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
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
                        const StackRow(
                          title: "URL Launcher",
                          value: "URL Launcher",
                          about:
                              "Library to open links and external URLs within the app.",
                          icon: "assets/img/flutter.png",
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("And many more packages...",
                            style: TextStyle(
                                color: TColor.gray20,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 8),
                        child: Text(
                          "Design & UI",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: TColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
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
                        const StackRow(
                          title: "Trackizer Template",
                          value: "Trackizer Template",
                          about:
                              "The design of the BudgetBuddy app is inspired by the Trackizer template, which provides a clean and modern aesthetic. The UI components from this template have been customized and coded by our team to fit the specific needs of BudgetBuddy. This template is license-free, and all backend functionality has been developed in-house to ensure a seamless integration with our custom features.",
                          icon: "assets/img/flutter.png",
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            _redirectToWeb();
                          },
                          child: Text("Link to template.",
                              style: TextStyle(
                                  color: TColor.gray20,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
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
      )),
    );
  }

  _redirectToWeb() {
    var url = Uri.parse("https://symu.co/freebies/templates-4/trackizer/");
    launchUrl(url);
  }
}
