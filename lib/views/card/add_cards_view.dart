import 'package:budgetbuddy/common_widget/primary_button.dart';
import 'package:budgetbuddy/views/main_tab/main_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../common/color_extension.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

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

  var cardNumber = "";
  var cardName = "";
  var validTill = "";
  var cvv = "";
  var cardType = "";

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
                Text("Card Type",
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
                    onChanged: (value) {
                      setState(() {
                        cardType = value;
                      });
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Visa",
                      hintStyle: TextStyle(color: TColor.gray50),
                      contentPadding: const EdgeInsets.only(left: 15),
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
                Text("Card Holder Name",
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
                    onChanged: (value) {
                      setState(() {
                        cardName = value;
                      });
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Aditya Yadav",
                      hintStyle: TextStyle(color: TColor.gray50),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 15),
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
                Text("Card  Number",
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
                    onChanged: (value) {
                      setState(() {
                        cardNumber = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    maxLength: 19,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CardNumberFormatter()
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "**** **** **** 7856",
                      hintStyle: TextStyle(color: TColor.gray50),
                      contentPadding: const EdgeInsets.only(left: 15),
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
                    onChanged: (value) {
                      setState(() {
                        validTill = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [CreditCardExpirationDateFormatter()],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "08 / 27",
                      hintStyle: TextStyle(color: TColor.gray50),
                      contentPadding: const EdgeInsets.only(left: 15),
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
                Text("CVV",
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
                    onChanged: (value) {
                      setState(() {
                        cvv = value;
                      });
                    },
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    inputFormatters: [CreditCardCvcInputFormatter()],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "***",
                      hintStyle: TextStyle(color: TColor.gray50),
                      contentPadding: const EdgeInsets.only(left: 15),
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
              height: media.height * 0.15,
            ),
            Container(
              width: media.width * 0.9,
              child: PrimaryButton(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  title: "Add Card",
                  onPressed: () {
                    _submitCard();
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        )),
      ),
    );
  }

  _submitCard() async {
    if (cardName.isEmpty ||
        cardNumber.isEmpty ||
        validTill.isEmpty ||
        cvv.isEmpty ||
        cardType.isEmpty) {
      return Get.snackbar("Error", "Please fill all fields",
          colorText: TColor.white);
    } else if (cardNumber.length < 16) {
      return Get.snackbar("Error", "Card number must be 16 digits",
          colorText: TColor.white);
    } else if (validTill.length < 5) {
      return Get.snackbar("Error", "Valid till must be 5 digits",
          colorText: TColor.white);
    } else if (cvv.length < 3) {
      return Get.snackbar("Error", "CVV must be 3 digits",
          colorText: TColor.white);
    } else {
      var box = await Hive.openBox("user");
      var cards = box.get("cards", defaultValue: []);
      cards.add({
        "name": cardName,
        "number": cardNumber,
        "month_year": validTill,
        "cvv": cvv,
        "type": cardType
      });
      box.put("cards", cards);
      Get.offAll(const MainTabView());
    }
    print("submitting card");
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
