import 'package:flutter/material.dart';
import 'package:registration/generated/l10n.dart';
import 'package:registration/pages/sign_in/form_section_signin.dart';
import '../../resources/assets_manager.dart';
import '../../resources/text_style.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool obsecureText = true;

  bool isObsecureText = true;

  @override
  void initState() {
    super.initState();
  }

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
                  child: ListView(children: [
                    Image.asset(
                      ImageAssets.logo,
                      scale: 3,
                    ),
                    Center(
                      child: Text(
                        S.of(context).signIn,
                        style: TextStyles.textStyleBold22White
                            .copyWith(height: 1.5),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const FormSectionSignIn(),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
