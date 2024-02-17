import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/generated/l10n.dart';
import 'package:registration/providers/forget_password_provider.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/text_button_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  void initState() {
    Provider.of<ForgetPasswordProvider>(context, listen: false).init();
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
                        S.of(context).forgetPassword,
                        style: TextStyles.textStyleBold22White
                            .copyWith(height: 1.5),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Consumer<ForgetPasswordProvider>(
                        builder: (BuildContext context,
                                ForgetPasswordProvider provider,
                                Widget? child) =>
                            Form(
                                key: provider.formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0),
                                        child: CustomTextFormField(
                                          controller: provider.emailController!,
                                          hintForMsg: AppStrings.emailHintText,
                                          hintText: S.of(context).emailHintText,
                                          prefixIcon: Icons.email,
                                          obsecureType: false,
                                          isObsecureText: false,
                                          inputType: TextInputType.emailAddress,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Consumer<ForgetPasswordProvider>(
                                        builder: (BuildContext context,
                                            ForgetPasswordProvider value,
                                            Widget? child) {
                                          return TextButtonWidget(
                                              buttonText:
                                                  S.of(context).sendMail,
                                              textStyle: TextStyles
                                                  .textStyleRegular16White,
                                              onPressed: () {
                                                provider
                                                    .forgetPassword(context);
                                              });
                                        },
                                      ),
                                    ],
                                  ),
                                )))
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
