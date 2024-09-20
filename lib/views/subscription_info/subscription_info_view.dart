import 'package:budgetbuddy/views/main_tab/main_tab_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:budgetbuddy/common_widget/secondary_button.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../common/color_extension.dart';
import '../../common_widget/item_row.dart';

class SubscriptionInfoView extends StatefulWidget {
  final Map sObj;
  final len;
  const SubscriptionInfoView(
      {super.key, required this.sObj, required this.len});

  @override
  State<SubscriptionInfoView> createState() => _SubscriptionInfoViewState();
}

class _SubscriptionInfoViewState extends State<SubscriptionInfoView> {
  var paymentTime = "08.07.2023";
  var category = "Enterteintment";

  void getSubData() async {
    var subBox = await Hive.openBox("subscription");
    var subArr = subBox.get("arr");
    var arrayOfData = subArr[widget.len];

    setState(() {
      paymentTime = arrayOfData["paymentTime"];
      category = arrayOfData["type"];
    });
  }

  void deleteSub() {
    isWantToDelete = true;
  }

  void finallyDeleteSub() async {
    if (isConfirmDelete) {
      var subBox = await Hive.openBox("subscription");
      var totalSpent = await Hive.openBox("totalSpent");

      var subArr = subBox.get("arr");
      var catBox = await Hive.openBox("categories");
      var catArr = catBox.get("categories") ?? [];
      var totalSpentValue = totalSpent.get("totalSpent");
      double ts = double.parse(totalSpentValue.toString());

      // Get the price and type (category) of the item being deleted
      var itemPrice = double.parse(widget.sObj["price"].toString());
      var itemCategory =
          widget.sObj["type"]; // Assuming "type" is the category of the item

      // Find the relevant category in subArr
      for (var category in catArr) {
        if (category["name"] == itemCategory) {
          // Update the spend_amount and left_amount of the category
          double currentSpent = double.parse(category["spend_amount"]);
          double currentLeft = double.parse(category["left_amount"]);

          // Subtract item price from spent and add back to left amount
          category["spend_amount"] =
              (currentSpent - itemPrice).toStringAsFixed(1);
          category["left_amount"] =
              (currentLeft + itemPrice).toStringAsFixed(1);
          break;
        }
      }

      // Update the total spent amount
      double finalTs = ts - itemPrice;
      totalSpent.put("totalSpent", finalTs);

      // Remove the item from subArr
      subArr.removeAt(widget.len);
      subBox.put("arr", subArr); // Save updated subArr back into the box

      Get.snackbar("Deleted", "Deleted this transaction successfully!",
          colorText: TColor.white);
    }
  }

  bool isWantToDelete = false;
  bool isConfirmDelete = false;

  @override
  void initState() {
    super.initState();
    getSubData();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff282833).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Container(
                      height: media.width * 0.9,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: TColor.gray70,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Image.asset("assets/img/dorp_down.png",
                                    width: 20,
                                    height: 20,
                                    color: TColor.gray30),
                              ),
                              Text(
                                "Transaction info",
                                style: TextStyle(
                                    color: TColor.gray30, fontSize: 16),
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteSub();
                                  Get.defaultDialog(
                                    title: "Save changes",
                                    backgroundColor: TColor.gray70,
                                    titleStyle: TextStyle(
                                        color: TColor.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                    content: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Are you sure you want to delete this subscription?",
                                            style: TextStyle(
                                                color: TColor.gray30,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          SecondaryButton(
                                            title: "Cancel",
                                            onPressed: () {
                                              setState(() {
                                                isConfirmDelete = false;
                                              });
                                              Navigator.pop(context);
                                            },
                                            asset:
                                                "assets/img/secondary_btn.png",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SecondaryButton(
                                            title: "Delete",
                                            onPressed: () {
                                              setState(() {
                                                isConfirmDelete = true;
                                              });
                                              Navigator.pop(context);
                                            },
                                            asset:
                                                "assets/img/secondary_btn.png",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                icon: Image.asset("assets/img/Trash.png",
                                    width: 25,
                                    height: 25,
                                    color: TColor.gray30),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Image.asset(
                            widget.sObj["icon"],
                            width: media.width * 0.25,
                            height: media.width * 0.25,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.sObj["name"],
                            style: TextStyle(
                                color: TColor.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "₹${widget.sObj["price"]}",
                            style: TextStyle(
                                color: TColor.gray30,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: TColor.border.withOpacity(0.1),
                              ),
                              color: TColor.gray60.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                ItemRow(
                                  title: "Name",
                                  value: widget.sObj["name"],
                                ),
                                ItemRow(
                                  title: "Category",
                                  value: category,
                                ),
                                ItemRow(
                                  title: "Paid on",
                                  value: paymentTime,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SecondaryButton(
                            title: "Save",
                            onPressed: () {
                              if (isConfirmDelete) {
                                finallyDeleteSub();
                                Get.to(() => const MainTabView(),
                                    transition: Transition.rightToLeftWithFade,
                                    duration:
                                        const Duration(milliseconds: 500));
                              } else {
                                Get.snackbar("Saved", "Saved this transaction!",
                                    colorText: TColor.white);
                                Get.to(() => const MainTabView(),
                                    transition: Transition.rightToLeftWithFade,
                                    duration:
                                        const Duration(milliseconds: 500));
                              }
                            },
                            asset: "assets/img/secondary_btn.png",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 4, right: 4),
                height: media.width * 0.9 + 15,
                alignment: Alignment.bottomCenter,
                child: Row(children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: TColor.gray,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Expanded(
                      child: DottedBorder(
                    dashPattern: const [5, 10],
                    padding: EdgeInsets.zero,
                    strokeWidth: 1,
                    child: SizedBox(
                      height: 0,
                    ),
                    radius: const Radius.circular(16),
                    color: TColor.gray,
                  )),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: TColor.gray,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
