import 'dart:math';

import 'package:budgetbuddy/views/card/add_cards_view.dart';
import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:budgetbuddy/common/color_extension.dart';
import 'package:budgetbuddy/views/settings/settings_view.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CardsView extends StatefulWidget {
  const CardsView({super.key});

  @override
  State<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  bool isCards = true;

  List carArr = [
    {
      "name": "code for any1",
      "number": "**** **** **** 2197",
      "month_year": "08/27"
    },
    {
      "name": "code for any2",
      "number": "**** **** **** 2198",
      "month_year": "09/27"
    },
    {
      "name": "code for any3",
      "number": "**** **** **** 2297",
      "month_year": "07/27"
    },
    {
      "name": "code for any4",
      "number": "**** **** **** 2397",
      "month_year": "05/27"
    },
  ];

  SwiperController controller = SwiperController();

  Widget buildSwiper() {
    return Swiper(
      loop: false,
      itemCount: carArr.length,
      customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
        ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
        ..addTranslate([
          const Offset(-370.0, -40.0),
          Offset.zero,
          const Offset(370.0, -40.0),
        ]),
      fade: 1.0,
      onIndexChanged: (index) {
        print(index);
      },
      scale: 0.8,
      itemWidth: 232.0,
      itemHeight: 350,
      controller: controller,
      layout: SwiperLayout.STACK,
      viewportFraction: 0.8,
      itemBuilder: ((context, index) {
        var cObj = carArr[index] as Map? ?? {};
        return Container(
          decoration: BoxDecoration(
              color: TColor.gray70,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 4)
              ]),
          child: Stack(fit: StackFit.expand, children: [
            Image.asset(
              "assets/img/card_blank.png",
              width: 232.0,
              height: 350,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset("assets/img/mastercard_logo.png", width: 50),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  cObj["type"] ?? "Mastercard",
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 115,
                ),
                Text(
                  cObj["name"] ?? "Aditya",
                  style: TextStyle(
                      color: TColor.gray20,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  cObj["number"] ?? "**** **** **** 2197",
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  cObj["month_year"] ?? "08/27",
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            )
          ]),
        );
      }),
      autoplayDisableOnInteraction: false,
      axisDirection: AxisDirection.right,
    );
  }

  void checkData() async {
    var userBox = await Hive.openBox('user');
    var cards = userBox.get('cards');

    if (cards == null) {
      setState(() {
        isCards = false;
      });
    } else {
      setState(() {
        isCards = true;
        carArr = cards;
      });
    }

    print(cards);
  }

  @override
  void initState() {
    super.initState();
    checkData();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              height: 600,
              child: Container(
                width: double.infinity,
                height: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isCards
                        ? buildSwiper()
                        : Text("No cards added yet.",
                            style: TextStyle(
                                color: TColor.gray30,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 380,
            ),
            Column(
              children: [
                SafeArea(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Credit Cards",
                            style:
                                TextStyle(color: TColor.gray30, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingsView()));
                              },
                              icon: Image.asset("assets/img/settings.png",
                                  width: 25, height: 25, color: TColor.gray30))
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 500,
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                          color: TColor.gray70.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                Get.to(() => AddCardsView(),
                                    transition: Transition.leftToRightWithFade,
                                    duration:
                                        const Duration(milliseconds: 500));
                              },
                              child: DottedBorder(
                                dashPattern: const [5, 4],
                                strokeWidth: 1,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(16),
                                color: TColor.border.withOpacity(0.1),
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Add new card",
                                        style: TextStyle(
                                            color: TColor.gray30,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Image.asset(
                                        "assets/img/add.png",
                                        width: 12,
                                        height: 12,
                                        color: TColor.gray30,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
