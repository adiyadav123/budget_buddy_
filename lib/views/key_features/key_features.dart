import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/color_extension.dart';
import '../../common_widget/stack_row.dart';

class KeyFeaturesView extends StatefulWidget {
  const KeyFeaturesView({super.key});

  @override
  State<KeyFeaturesView> createState() => _KeyFeaturesViewState();
}

class _KeyFeaturesViewState extends State<KeyFeaturesView> {
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
                        icon: Icon(Icons.arrow_back,
                            color: TColor.gray30, size: 25),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Key Features",
                        style: TextStyle(color: TColor.gray30, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              Image.asset(
                "assets/img/key_features.png",
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
                            "Features",
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
                            title: "Intuitive Budget Management",
                            value: "Intuitive Budget Management",
                            about:
                                "Easily track and manage your finances with a simple and user-friendly interface.",
                            icon: "assets/img/flutter.png",
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          StackRow(
                            title: "Expense Tracking",
                            value: "Expense Tracking",
                            about:
                                "Monitor your spending across various categories to stay within your budget.",
                            icon: "assets/img/flutter.png",
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          StackRow(
                            title: "Customizable Categories",
                            value: "Customizable Categories",
                            about:
                                "Use predefined categories to organize your expenses effectively.",
                            icon: "assets/img/flutter.png",
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          StackRow(
                            title: "Smart Notifications",
                            value: "Smart Notifications",
                            about:
                                "Receive timely alerts and reminders to help you stay on top of your financial goals.",
                            icon: "assets/img/flutter.png",
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          StackRow(
                            title: "Budgeting Insights",
                            value: "Budgeting Insights",
                            about:
                                "Get insights into your spending patterns to make informed financial decisions.",
                            icon: "assets/img/flutter.png",
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          StackRow(
                            title: "Secure Data Storage",
                            value: "Secure Data Storage",
                            about:
                                "Your financial data is stored securely with robust encryption to ensure privacy and protection.",
                            icon: "assets/img/flutter.png",
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          StackRow(
                            title: "Easy Navigation",
                            value: "Easy Navigation",
                            about:
                                "The app features an easy-to-navigate design that enhances user experience.",
                            icon: "assets/img/flutter.png",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: media.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _redirectToWeb() {
    var url = Uri.parse("https://symu.co/freebies/templates-4/trackizer/");
    launchUrl(url);
  }
}
