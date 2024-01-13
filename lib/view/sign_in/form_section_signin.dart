import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/resources/strings_manager.dart';
import 'package:registration/view/sign_in/logic/login_provider.dart';
import 'package:registration/view/sign_up/signup_screen.dart';
import '../../resources/text_style.dart';
import '../../utils/navigation.dart';
import '../home/home_screen.dart';
import '../widgets/costom_text_form_field.dart';
import '../widgets/text_button_widget.dart';

class FormSectionSignIn extends StatefulWidget {
  const FormSectionSignIn({super.key});

  @override
  State<FormSectionSignIn> createState() => _FormSectionSignInState();
}

class _FormSectionSignInState extends State<FormSectionSignIn> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: CostomTextFormField(
                  controller: emailController,
                  hintText: AppStrings.emailHintText,
                  prefixIcon: Icons.email,
                  obsecureType: false,
                  isObsecureText: false,
                  inputType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: CostomTextFormField(
                    controller: passwordController,
                    hintText: AppStrings.password,
                    prefixIcon: Icons.lock,
                    obsecureType: true,
                    isObsecureText: true,
                    inputType: TextInputType.visiblePassword),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.forgetPassword,
                      style: TextStyles.textStyleRegular12Blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<LoginProvider>(
                builder:
                    (BuildContext context, LoginProvider value, Widget? child) {
                  return TextButtonWidget(
                      buttonText: AppStrings.signIn,
                      textStyle: TextStyles.textStyleRegular16White,
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                        value.login(emailController.text,
                                  passwordController.text, context);

                          print("login Successfully.");
                        }
                      });
                },
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.donotHaveAccount,
                        style: TextStyles.textStyleRegular16Grey
                            .copyWith(height: 1.5)),
                    GestureDetector(
                      onTap: () {
                        NavigationUtils.pushReplacement(
                            context: context, page: SignUpScreen());
                      },
                      child: Text(AppStrings.registerDot,
                          style: TextStyles.textStyleRegular16Orange
                              .copyWith(height: 1.5)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
