import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:registration/drawer_animation/drawer_screen.dart';
import 'package:registration/resources/constants_manager.dart';
import 'package:registration/resources/strings_manager.dart';

import 'package:registration/utils/navigation.dart';
import 'package:registration/view/home/home_screen.dart';
import 'package:registration/view/on_boarding/on_boarding_screen.dart';
import 'package:registration/view/splash/widgets/splash_logo_and_title.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool isLoggedIn;

  _startDelay() {
    getValidateData().whenComplete(() {
      Timer(const Duration(seconds: AppConstants.splashDelay), () => _goNext());
    });
  }

  _goNext() {
    if (isLoggedIn) {
      NavigationUtils.pushReplacement(context: context, page: DrawerScreen());
      // Navigator.pushReplacementNamed(context, Routes.homeScreen);
    } else {
      NavigationUtils.pushReplacement(
          context: context, page: const OnBoardingScreen());

      // Navigator.pushReplacementNamed(context, Routes.onBoardingScreen);
    }
  }

  Future getValidateData() async {
    // isLoggedIn = PreferencesService.retrieveBoolValueIsLoggedIn();
    isLoggedIn =
        GetIt.I.get<SharedPreferences>().getBool(AppStrings.isLoggedInPref) ??
            false;
    print("loggedIn splash $isLoggedIn");
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
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
