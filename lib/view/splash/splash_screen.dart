import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registration/view/drawer/drawer_screen.dart';
import 'package:registration/resources/strings_manager.dart';
import 'package:registration/utils/navigation.dart';
import 'package:registration/view/on_boarding/on_boarding_screen.dart';
import 'package:registration/view/splash/widgets/splash_logo_and_title.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getValidateData() async {
    // isLoggedIn = PreferencesService.retrieveBoolValueIsLoggedIn();
    // isLoggedIn =
    //     GetIt.I.get<SharedPreferences>().getBool(AppStrings.isLoggedInPref) ??
    //         false;
    // print("loggedIn splash $isLoggedIn");
    await Future.delayed(const Duration(seconds: 1));

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        NavigationUtils.pushReplacement(
            context: context, page: const OnBoardingScreen());
      } else {
        NavigationUtils.pushReplacement(context: context, page: DrawerScreen());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // _startDelay();
    getValidateData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SplashLogoAndTitle(
              height: height,
              width: width,
              mainAxisAlignment: MainAxisAlignment.center,
              textTitle: AppStrings.splashTitle),
        ));
  }
}
