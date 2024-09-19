import 'package:budgetbuddy/views/login/config.dart';
import 'package:budgetbuddy/views/login/welcome.dart';
import 'package:budgetbuddy/views/main_tab/main_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../common/color_extension.dart';
import '../../common_widget/icon_item_row.dart';
import 'package:url_launcher/url_launcher.dart';

class AddCardsView extends StatefulWidget {
  const AddCardsView({super.key});

  @override
  State<AddCardsView> createState() => _AddCardsViewState();
}

class _AddCardsViewState extends State<AddCardsView> {
  void setDailyTips(isActive) async {
    var box = await Hive.openBox("user");
    box.put("dailyTips", isActive);

    print("set data: $isActive");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      "Add Card",
                      style: TextStyle(color: TColor.gray30, fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: media.height * 0.1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Card Name",
                    style: TextStyle(
                      color: TColor.gray50,
                      fontSize: 14,
                    )),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: media.width * 0.9,
                  height: 48,
                  decoration: BoxDecoration(
                    color: TColor.gray60.withOpacity(0.1),
                    border: Border.all(
                      color: TColor.gray70,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                    style: TextStyle(
                      color: TColor.white,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Card Number",
                    style: TextStyle(
                      color: TColor.gray50,
                      fontSize: 14,
                    )),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: media.width * 0.9,
                  height: 48,
                  decoration: BoxDecoration(
                    color: TColor.gray60.withOpacity(0.1),
                    border: Border.all(
                      color: TColor.gray70,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                    style: TextStyle(
                      color: TColor.white,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Valid till",
                    style: TextStyle(
                      color: TColor.gray50,
                      fontSize: 14,
                    )),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: media.width * 0.9,
                  height: 48,
                  decoration: BoxDecoration(
                    color: TColor.gray60.withOpacity(0.1),
                    border: Border.all(
                      color: TColor.gray70,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                    style: TextStyle(
                      color: TColor.white,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: media.height * 0.1,
            )
          ],
        )),
      ),
    );
  }

  _redirectToGithub() {
    var url = Uri.parse("https://github.com/adiyadav123/budget_buddy_");
    launchUrl(url);
  }
}
