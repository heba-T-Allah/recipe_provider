import 'package:flutter/material.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import 'form_section_signup.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        currentFocus.unfocus();
        print("tapped");
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageAssets.bgMask),
                        fit: BoxFit.cover,
                      )),
                  child: ListView(
                      children: [
                        Image.asset(
                          ImageAssets.logo,
                          scale: 3,
                        ),

                        Center(
                          child: Text(
                            AppStrings.signUp,
                            style: TextStyles.textStyleBold22White
                                .copyWith(height: 1.5),
                          ),
                        ),
                        SizedBox(
                          height:20,
                        ),
                   const FormSectionSignUp(),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
