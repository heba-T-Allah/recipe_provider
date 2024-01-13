import 'package:flutter/material.dart';
import 'package:registration/resources/strings_manager.dart';
import 'package:registration/resources/text_style.dart';
import 'package:registration/resources/values_manager.dart';
import 'package:registration/view/sign_in/signin_screen.dart';
import 'package:registration/view/sign_up/signup_screen.dart';
import '../../utils/navigation.dart';
import '../splash/widgets/splash_logo_and_title.dart';
import '../widgets/text_button_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: SingleChildScrollView(
        child: Stack(children: [
          SplashLogoAndTitle(height: height, width: width,
            mainAxisAlignment: MainAxisAlignment.center,
              textTitle:AppStrings.splashTitle ),

          //register button
          Positioned(
            bottom: AppSize.s80,
            left: 0,
            right: 0,
            child: TextButtonWidget(
              buttonText: AppStrings.register,
              textStyle: TextStyles.textStyleRegular16White,
              onPressed: () =>
                  NavigationUtils.pushReplacement(context: context,page: const SignUpScreen()),

              // Navigator.pushReplacementNamed(context, Routes.signUpScreen),
            ),
          ),

          const SizedBox(height: AppSize.s20),
          //sign In button
          Positioned(
            bottom: AppSize.s10,
            left: 0,
            right: 0,
            child: TextButton(
              onPressed: () {
                NavigationUtils.pushReplacement(context: context,page: const SignInScreen());

                // Navigator.pushReplacementNamed(context, Routes.signInScreen);
              },
              child: Text(
                AppStrings.signIn,
                style: TextStyles.textStyleRegular16White,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
