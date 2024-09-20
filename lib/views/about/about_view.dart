import 'package:budgetbuddy/views/login/config.dart';
import 'package:budgetbuddy/views/login/welcome.dart';
import 'package:budgetbuddy/views/main_tab/main_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../common/color_extension.dart';
import '../../common_widget/icon_item_row.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
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
                      "About Us",
                      style: TextStyle(color: TColor.gray30, fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
            Image.asset(
              "assets/img/about_us.png",
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Budget Buddy",
              style: TextStyle(
                  color: TColor.gray30,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Version 1.0.0",
              style: TextStyle(color: TColor.gray30, fontSize: 12),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Developed by - Team CF - 05",
              style: TextStyle(color: TColor.gray30, fontSize: 12),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Participant Name - Aditya Yadav",
              style: TextStyle(color: TColor.gray30, fontSize: 12),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Take control of your finances, one step at a time.",
              style: TextStyle(
                color: TColor.gray50,
                fontSize: 14,
                fontStyle: FontStyle.italic,
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
}
