import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/color_extension.dart';

class AppGuideView extends StatefulWidget {
  const AppGuideView({super.key});

  @override
  State<AppGuideView> createState() => _AppGuideViewState();
}

class _AppGuideViewState extends State<AppGuideView> {
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
                        "App Guide",
                        style: TextStyle(color: TColor.gray30, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              Image.asset(
                "assets/img/guide.png",
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
                            "How to Use the App",
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
                          ListTile(
                            title: Text(
                              "Change Budget",
                              style: TextStyle(color: TColor.white),
                            ),
                            subtitle: Text(
                              "You can change your budget by clicking on the budget amount on the home page.",
                              style: TextStyle(color: TColor.gray30),
                            ),
                          ),
                          Divider(color: TColor.border),
                          ListTile(
                            title: Text(
                              "Enter Custom Transaction Amount",
                              style: TextStyle(color: TColor.white),
                            ),
                            subtitle: Text(
                              "Click on the price in the 'Add Transaction' page to enter a custom amount.",
                              style: TextStyle(color: TColor.gray30),
                            ),
                          ),
                          Divider(color: TColor.border),
                          ListTile(
                            title: Text(
                              "View Analytics",
                              style: TextStyle(color: TColor.white),
                            ),
                            subtitle: Text(
                              "Click on 'See Budget' below the budget on the home page to view your analytics.",
                              style: TextStyle(color: TColor.gray30),
                            ),
                          ),
                          Divider(color: TColor.border),
                          ListTile(
                            title: Text(
                              "View Transaction Details",
                              style: TextStyle(color: TColor.white),
                            ),
                            subtitle: Text(
                              "Click on 'Transactions' in the home page to view the details of your transactions.",
                              style: TextStyle(color: TColor.gray30),
                            ),
                          ),
                          Divider(color: TColor.border),
                          ListTile(
                            title: Text(
                              "Enable Screen Lock",
                              style: TextStyle(color: TColor.white),
                            ),
                            subtitle: Text(
                              "You can enable screen lock from the settings menu to secure your app.",
                              style: TextStyle(color: TColor.gray30),
                            ),
                          ),
                          Divider(color: TColor.border),
                          ListTile(
                            title: Text(
                              "Enable Daily Tips Notification",
                              style: TextStyle(color: TColor.white),
                            ),
                            subtitle: Text(
                              "Turn on daily tips notifications from settings to get useful budgeting advice.",
                              style: TextStyle(color: TColor.gray30),
                            ),
                          ),
                          Divider(color: TColor.border),
                          ListTile(
                            title: Text(
                              "Save Your Credit Cards",
                              style: TextStyle(color: TColor.white),
                            ),
                            subtitle: Text(
                              "You can securely save your credit card details for easy transactions in the settings menu.",
                              style: TextStyle(color: TColor.gray30),
                            ),
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
