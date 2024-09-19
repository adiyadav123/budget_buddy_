import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:budgetbuddy/common/color_extension.dart';
import 'package:budgetbuddy/common_widget/budgets_row.dart';
import 'package:budgetbuddy/common_widget/custom_arc_180_painter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../settings/settings_view.dart';

class SpendingBudgetsView extends StatefulWidget {
  const SpendingBudgetsView({super.key});

  @override
  State<SpendingBudgetsView> createState() => _SpendingBudgetsViewState();
}

class _SpendingBudgetsViewState extends State<SpendingBudgetsView> {
  List s = [];
  String _prediction = "";
  double budget = 0.0;
  double totalSpent = 0.0;
  double totalBudgetSpent = 0.0;

  List<String> overspendingAdvices = [
    "Whoa! 😮 You've gone overboard in some areas. Let's scale back a little to avoid breaking the bank! 💸",
    "Yikes! You've spent a bit too much in a few spots. Time to reign it in and make sure you stay on track. 💼",
    "Uh oh! ⚠️ Your wallet's feeling the heat. Try cutting back on non-essentials to stay within your budget! 🔥",
    "You're spending a lot here! 😬 How about holding off on some purchases to ease up the pressure?",
    "You've really pushed your limits in some categories! 🧯 Time to pull back and give your budget some breathing room.",
    "Phew! That was close! 😅 You’ve almost maxed out your budget. Let's trim down some spending.",
    "Hey, you've splurged a bit too much in certain areas. ✂️ Consider trimming back a little to keep things in check.",
    "Careful! 🚨 You're spending quite a lot. Cut back on the extras and keep things under control!",
    "Heads up! You're spending heavily in some places. Tighten up a little to balance things out. 🏦",
    "Oh no! 🛑 Some categories are way over budget. Better slow down and rethink your priorities.",
    "Looks like you’re on the fast track to overspending! 🚀 Take a moment to reassess your priorities.",
    "Whoa, your spending is getting out of hand! 🤑 Time to put the brakes on and evaluate your needs.",
    "Hold up! 🚥 You're dipping into your budget a little too much. Time to pause and plan your next moves.",
    "Careful there! ⚡ You've spent quite a bit already. Maybe skip the extra coffee this week?",
    "You're dangerously close to your budget limits! ⚠️ It’s time to think about cutting back on some indulgences.",
    "Whoa! You've been splashing cash! 💰 Let’s tighten the purse strings a bit for a smoother ride.",
  ];

  List<String> nearingBudgetLimitAdvices = [
    "Heads up! ⚠️ You're close to hitting your budget limit. Keep it steady and avoid overspending!",
    "You're nearing your budget! Stay sharp and make wise spending choices from here on out. 💡",
    "Careful! 🚦 You're getting close to maxing out your budget. Time to slow down and plan for the rest of the month.",
    "Watch out! 📊 You're about to hit your budget cap. Keep an eye on your spending and adjust where necessary.",
    "You're on the edge! ⏳ Slow down your spending before it gets out of hand.",
    "Your budget is running thin! 🏃‍♂️ Keep your expenses minimal from here on out.",
    "Easy there! 🛑 You're getting close to the budget cap. Stay mindful of your spending.",
    "You're right on the verge! 📉 Try holding back on unnecessary expenses to stay within your limit.",
    "You’re approaching your limit. 🚧 Time to slow down on spending and prioritize essential needs.",
    "Almost there! Keep an eye on your balance and plan for the rest of your budget wisely. 🎯",
    "You're tiptoeing close to the edge! 🌪️ A little caution now could save you a lot later!",
    "Almost at the finish line! 🏁 Watch your spending closely; a few careful choices can keep you balanced.",
    "You’re walking a fine line! 🔍 Stay vigilant with your expenses to avoid going overboard.",
    "You're just a step away from hitting your limit! 👣 It’s time to reevaluate your spending habits.",
    "Keep it steady! 🌊 You’re close to maxing out your budget. Focus on essentials for now.",
    "Caution! 🚧 You're nearing your financial finish line. It might be wise to slow down your spending.",
  ];

  List<String> underBudgetAdvices = [
    "You're doing amazing! 🎉 You've used less than 25% of your budget. Enjoy the extra breathing space!",
    "Great job! 🙌 You’ve spent very little so far. You’re totally in control of your finances!",
    "Awesome work! 🏆 You've only spent a fraction of your budget. Keep it up!",
    "You're smashing it! 😎 You've kept your spending super low. Treat yourself a little if everything’s covered!",
    "Well done! 💪 You’re under budget and it looks like you’re nailing your financial goals.",
    "Fantastic! 👏 Your spending is on point and under control. You’re in a great position for the rest of the month.",
    "Keep up the great work! 🏆 All categories are looking balanced, and you're in complete control of your spending.",
    "Nice work! 🎯 You’ve barely made a dent in your budget. You’re managing your finances like a pro!",
    "Excellent! 💼 You’re well within your budget. Maybe reward yourself with something small if you’re feeling secure.",
    "You’re on fire! 🔥 Your spending is super low, and you’re totally in control of your financial goals.",
    "Incredible! 🌟 You’ve saved a lot so far. Maybe think about using some of that for a little treat!",
    "You’re cruising under budget! 🚙 Time to relax a bit; you’ve earned it!",
    "Great to see you saving money! 💵 It’s a perfect time to think about investing in something fun!",
    "Wow, look at you go! 🌈 Your savings are impressive. Don’t forget to treat yourself occasionally!",
    "You’re on the right track! 🌠 Your budget is looking fantastic, keep making those wise choices!",
    "Awesome! 🎉 Your spending is low, and it looks like you’re setting yourself up for great success!",
  ];

  List<String> wellBalancedAdvices = [
    "You're a budget master! 🎯 Everything looks balanced and you're spending wisely across the board. Keep going!",
    "Amazing! 👏 You’ve kept your spending well-balanced across all categories. Great work!",
    "You're managing things like a pro! 🧠 All categories are in check, and you're on track to meet your goals.",
    "Well done! 💼 Your budget and spending look totally balanced. Keep up the fantastic work!",
    "You're crushing it! 🎉 Every category is under control. Keep that momentum going!",
    "Great job! 👍 Your spending is balanced and you're making smart financial moves. Stay on this track!",
    "Keep up the great work! 🏆 All categories are looking balanced, and you're in complete control of your spending.",
    "You’re rocking it! 🎸 Everything looks well-balanced, and you’ve got your budget in check.",
    "Fantastic! 🏅 Your budget is on track, and your spending is balanced across categories. Keep going!",
    "You're on top of things! 📊 Everything’s balanced and you’re managing your budget like a true pro.",
    "Incredible balance! 💪 You’re handling your finances like a champ. Keep making those wise decisions!",
    "You’re hitting the sweet spot! 🍭 Everything's balanced, and you’re making great progress towards your goals.",
    "Perfectly balanced! ⚖️ Your spending is just right across the board. Keep riding this wave!",
    "Bravo! 🎊 Your financial health is looking great. Keep up the awesome work!",
    "You're in the zone! 🌟 Your budget is balanced, and your spending is well-managed. Stay focused!",
    "Wonderful job! 🎈 Everything is harmonized in your budget. Keep up the fantastic progress!",
  ];

  List<String> oversavingAdvices = [
    "You’re way under budget! 💼 Maybe you can afford to treat yourself a little bit. 😎",
    "Whoa, you’ve been saving a lot! 💰 It’s okay to spend a bit more on things you need or want. 🎁",
    "You’re saving really well! 🏆 But hey, it's also okay to enjoy some of your money. Consider a small treat.",
    "Awesome job saving! 🙌 But don’t forget, it’s okay to spend on the essentials or something fun! 🧁",
    "Incredible savings! 🎉 But don’t forget, it’s okay to spend on the things you enjoy! Treat yourself!",
    "You’re way below budget! 🤩 Time to relax and treat yourself a bit. You've earned it!",
    "Looks like you're saving quite a lot! 💸 Consider loosening up the purse strings and enjoying some of your hard-earned money.",
    "You’re way ahead of your budget goals! 👏 It’s totally fine to spend a little more on something fun. 🍿",
    "You've been super frugal! 🏅 You could think about spending a bit more on the things you enjoy. 😇",
    "Amazing savings! 🎯 Don't forget to indulge a little and spend on things that matter to you. 🎁",
    "Great job on saving! 🏆 You’ve built a nice cushion. Maybe think about investing in some self-care! 🌸",
    "You're a savings superstar! 🌟 Don’t forget to reward yourself every now and then for your hard work!",
    "You've done fantastic at saving! 🎊 How about treating yourself to something nice? You deserve it!",
    "You’re saving big! 💵 Now might be a great time to spend on something that brings you joy! 🌼",
    "Incredible job on those savings! 🎈 Remember, it's perfectly okay to splurge a little sometimes!",
    "Your savings are impressive! 🎇 Consider using some of it for a small treat to celebrate your success!",
  ];

  List budgetArr = [
    {
      "name": "Entertainment",
      "icon": "assets/img/netflix_logo.png",
      "total_budget": "10000",
      "spend_amount": "0",
      "left_amount": "10000",
      "color": TColor.secondaryG.value
    },
    {
      "name": "Medicine",
      "icon": "assets/img/medicine.png",
      "total_budget": "10000",
      "spend_amount": "0",
      "left_amount": "10000",
      "color": TColor.secondary50.value
    },
    {
      "name": "Security",
      "icon": "assets/img/camera.png",
      "total_budget": "10000",
      "spend_amount": "0",
      "left_amount": "10000",
      "color": TColor.primary10.value
    },
    {
      "name": "Others",
      "icon": "assets/img/housing.png",
      "total_budget": "10000",
      "spend_amount": "5000",
      "left_amount": "5000",
      "color": Colors.yellow.value
    },
    {
      "name": "Food & Drinks",
      "icon": "assets/img/store.png",
      "total_budget": "60000",
      "spend_amount": "0",
      "left_amount": "60000",
      "color": Colors.blue.value
    }
  ];

  void checkData() async {
    print("checking data");
    var userBox = await Hive.openBox("user");
    var userBudget = userBox.get("budget");
    double d_budget = double.tryParse(userBudget) ?? 0.0;
    var totalBox = await Hive.openBox("totalSpent");
    var totalVal = totalBox.get('totalSpent') ?? 0;

    setState(() {
      totalBudgetSpent = totalVal;
    });

    setState(() {
      budget = d_budget;
    });

    var categoryBox = await Hive.openBox("categories");
    var catArr = categoryBox.get("categories");

    if (catArr != null) {
      List<dynamic> categoryList = catArr as List;
      print(categoryList);
      setState(() {
        budgetArr = categoryList;
      });

      String advice = "";
      bool balanced = true;
      double totalSpent = 0;
      double totalBudget = 0;
      int categoriesOverspent = 0;

      for (var category in budgetArr) {
        double catTotalBudget = double.parse(category['total_budget']);
        double spent = double.parse(category['spend_amount']);

        totalSpent += spent;
        totalBudget += catTotalBudget;

        if (spent > catTotalBudget * 0.9) {
          categoriesOverspent++;
        } else if (spent >= catTotalBudget * 0.75 &&
            spent <= catTotalBudget * 0.9) {
          balanced = false;
        }
      }

      double percentSpent = (totalSpent / totalBudget) * 100;
      Random random = Random();

      if (categoriesOverspent > 0) {
        advice =
            overspendingAdvices[random.nextInt(overspendingAdvices.length)];
      } else if (percentSpent > 75) {
        advice = nearingBudgetLimitAdvices[
            random.nextInt(nearingBudgetLimitAdvices.length)];
      } else if (percentSpent < 25) {
        advice = underBudgetAdvices[random.nextInt(underBudgetAdvices.length)];
      } else {
        advice =
            wellBalancedAdvices[random.nextInt(wellBalancedAdvices.length)];
      }

      setState(() {
        _prediction = advice;
      });
    } else {
      print("no categories added");
      categoryBox.put("categories", budgetArr);
      print("categories added");
    }
  }

  String formatNumber(int num) {
    if (num >= 10000000) {
      return '${(num / 10000000).toStringAsFixed(1)} Cr';
    } else if (num >= 100000) {
      return '${(num / 100000).toStringAsFixed(1)} L';
    } else if (num >= 1000) {
      return '${(num / 1000).toStringAsFixed(1)} K';
    } else {
      return num.toString();
    }
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35, right: 10),
              child: Row(
                children: [
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingsView()));
                      },
                      icon: Image.asset("assets/img/settings.png",
                          width: 25, height: 25, color: TColor.gray30))
                ],
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: media.width * 0.7,
                  height: media.width * 0.30,
                  child: CustomPaint(
                    painter: CustomArc180Painter(
                      drwArcs: [
                        ArcValueModel(color: TColor.secondaryG, value: 20),
                        ArcValueModel(color: TColor.secondary, value: 45),
                        ArcValueModel(color: TColor.primary10, value: 70),
                        ArcValueModel(color: Colors.yellow, value: 10),
                        ArcValueModel(color: Colors.blue, value: 20),
                      ],
                      end: 50,
                      width: 12,
                      bgWidth: 8,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "₹ ${formatNumber(totalBudgetSpent.toInt())} spent",
                      style: TextStyle(
                          color: TColor.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "of ₹ ${formatNumber(budget.toInt())} budget",
                      style: TextStyle(
                          color: TColor.gray30,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(children: [
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {},
                  child: Container(
                    width: media.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TColor.border.withOpacity(0.1),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            "$_prediction",
                            style: TextStyle(
                                color: TColor.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: budgetArr.length,
                itemBuilder: (context, index) {
                  var bObj = budgetArr[index] as Map? ?? {};

                  return BudgetsRow(
                    bObj: bObj,
                    onPressed: () {},
                  );
                }),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            //   child: InkWell(
            //     borderRadius: BorderRadius.circular(16),
            //     onTap: () {},
            //     child: DottedBorder(
            //       dashPattern: const [5, 4],
            //       strokeWidth: 1,
            //       borderType: BorderType.RRect,
            //       radius: const Radius.circular(16),
            //       color: TColor.border.withOpacity(0.1),
            //       child: Container(
            //         height: 64,
            //         padding: const EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(16),
            //         ),
            //         alignment: Alignment.center,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               "Add new category ",
            //               style: TextStyle(
            //                   color: TColor.gray30,
            //                   fontSize: 14,
            //                   fontWeight: FontWeight.w600),
            //             ),
            //             Image.asset(
            //               "assets/img/add.png",
            //               width: 12,
            //               height: 12,
            //               color: TColor.gray30,
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 110,
            ),
          ],
        ),
      ),
    );
  }
}
