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
  StreamSubscription<User?>? _listener;

  Future<void> getValidateData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (context.mounted)
    _listener = FirebaseAuth.instance.authStateChanges().listen((user) {
      user == null
          ? NavigationUtils.pushReplacement(
              context: context, page: const OnBoardingScreen())
          : NavigationUtils.pushReplacement(
              context: context, page: DrawerScreen());
    });
  }

  @override
  void dispose() {
    _listener?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    getValidateData();
    super.initState();
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
