import 'package:flutter/cupertino.dart';


abstract class NavigationUtils {
  static void push({required BuildContext context, required Widget page}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            alignment: Alignment.center,
            scale: Tween<double>(begin: 0.1, end: 1).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.bounceInOut,
              ),
            ),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return page;
        },
      ),
    );
  }

  static void pushReplacement(
      {required BuildContext context, required Widget page}) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            alignment: Alignment.center,
            scale: Tween<double>(begin: 0.1, end: 1).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.bounceInOut,
              ),
            ),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return page;
        },
      ),
    );
  }

  static void pushAndRemoveUntil(
      {required BuildContext context, required Widget page}) {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            alignment: Alignment.center,
            scale: Tween<double>(begin: 0.1, end: 1).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.bounceInOut,
              ),
            ),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return page;
        },
      ),
      (route) => false, // Remove all routes from the stack
    );
  }
}
