import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../pages/home/home_screen.dart';
import '../pages/on_boarding/on_boarding_screen.dart';
import '../pages/sign_in/signin_screen.dart';
import '../pages/sign_up/signup_screen.dart';
import '../pages/splash/splash_screen.dart';
import 'routes.dart';

class AppRouter {
  PageRoute? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );
      case Routes.signInScreen:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );
      case Routes.signUpScreen:
        return PageTransition(
            child: const SignUpScreen(),
            type: PageTransitionType.fade,
            curve: Curves.bounceInOut);
      case Routes.homeScreen:
        return PageTransition(
          child: HomeScreen(),
          type: PageTransitionType.leftToRightWithFade,
          settings: settings,
        );
      // MaterialPageRoute(
      // builder: (_) => const HomeScreen(),
      // );
      default:
        return null;
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("No route defined "),
        ),
        body: const Center(
          child: Text("No route defined"),
        ),
      ),
    );
  }
}
