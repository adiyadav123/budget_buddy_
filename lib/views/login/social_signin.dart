import 'package:budgetbuddy/common_widget/login_buttons.dart';
import 'package:budgetbuddy/views/home/home_view.dart';
import 'package:budgetbuddy/views/login/config.dart';
import 'package:budgetbuddy/views/login/email_signin.dart';
import 'package:budgetbuddy/views/login/signin.dart';
import 'package:budgetbuddy/views/login/social_config.dart';
import 'package:budgetbuddy/views/main_tab/main_tab_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../common/color_extension.dart';
import '../../common_widget/secondary_button.dart';

import 'package:google_sign_in/google_sign_in.dart';

class SocialSignIn extends StatefulWidget {
  const SocialSignIn({super.key});

  @override
  State<SocialSignIn> createState() => _SocialSignInState();
}

class _SocialSignInState extends State<SocialSignIn> {
  void checkUser() async {
    var box = await Hive.openBox("user");
    if (box.get("budget") != null) {
      Get.to(() => MainTabView(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 1000));
    } else {
      Get.to(() => ConfigPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 1000));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.gray80,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    "assets/img/app_logo.png",
                    width: media.width * 0.5,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  const SizedBox(
                    height: 15,
                  ),
                  LoginButton(
                      icon: "assets/img/google.png",
                      iconColor: TColor.gray,
                      textColor: TColor.gray,
                      shadowColor: TColor.white,
                      asset: "assets/img/google_btn.png",
                      title: "Sign in with Google",
                      onPressed: () {
                        _signInWithGoogle();
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  LoginButton(
                      icon: "assets/img/github.png",
                      iconColor: TColor.white,
                      shadowColor: TColor.gray80,
                      textColor: TColor.white,
                      asset: "assets/img/apple_btn.png",
                      title: "Sign in with Github",
                      onPressed: () {
                        _signInWithGithub();
                      }),
                  const SizedBox(height: 15),
                  Text("or",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.35), fontSize: 14)),
                  const SizedBox(height: 15),
                  SecondaryButton(
                      title: "Continue without signing in",
                      asset: "assets/img/secondary_btn.png",
                      onPressed: () {
                        checkUser();
                      },
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _signInWithGoogle() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    print("checking internet connection");
    print("isConnected: $isConnected");

    if (isConnected == false) {
      Get.snackbar(
          "Uh oh!", "Please make sure that your are connected to internet",
          colorText: Colors.white);
      return;
    }
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();

      FirebaseAuth auth = FirebaseAuth.instance;

      auth.signInWithProvider(googleAuthProvider).then((value) async {
        User? user = value.user;

        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text("Something unexpected occurred. Please sign in again")));

          return Get.to(() => SocialSignIn(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 1000));
        } else {
          var mail = user.email;

          if (mail == null) {
            var box = await Hive.openBox("user");
            box.put("method", "firebase");
            box.put("email", "$mail");
            return Get.to(() => ConfigPage(),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 1000));
          }

          var box = await Hive.openBox("user");
          box.put("method", "firebase");
          box.put("email", "$mail");

          Get.to(() => SocialConfigPage(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 1000));
        }
      });
    } catch (e) {
      return print(e);
    }
  }

  _signInWithGithub() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    print("checking internet connection");
    print("isConnected: $isConnected");

    if (isConnected == false) {
      Get.snackbar(
          "Uh oh!", "Please make sure that your are connected to internet",
          colorText: Colors.white);
      return;
    }
    GithubAuthProvider authProvider = GithubAuthProvider();
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithProvider(authProvider).then((value) {
      User? user = value.user;

      if (user == null) {
        Get.snackbar(
            "Uh oh!", "Something unexpected occurred. Please sign in again",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: TColor.gray80,
            colorText: TColor.white);

        return Get.to(() => SocialSignIn(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 1000));
      } else {
        Get.to(() => SocialConfigPage(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 1000));
      }
    });
  }
}
