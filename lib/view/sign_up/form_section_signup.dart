import 'package:flutter/material.dart';
import 'package:registration/resources/strings_manager.dart';
import 'package:registration/view/sign_in/signin_screen.dart';

import '../../resources/text_style.dart';
import '../../utils/navigation.dart';
import '../widgets/costom_text_form_field.dart';
import '../widgets/text_button_widget.dart';

class FormSectionSignUp extends StatefulWidget {
  const FormSectionSignUp({super.key});

  @override
  State<FormSectionSignUp> createState() => _FormSectionSignUpState();
}

class _FormSectionSignUpState extends State<FormSectionSignUp> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    fullNameController = TextEditingController();
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
                    controller: fullNameController,
                    hintText: AppStrings.emailHintText,
                    prefixIcon: Icons.person,
                    obsecureType: false,
                    isObsecureText: false,
                    inputType: TextInputType.text),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: CostomTextFormField(
                    controller: emailController,
                    hintText: AppStrings.fullNameHintText,
                    prefixIcon: Icons.email,
                    obsecureType: false,
                    isObsecureText: false,
                    inputType: TextInputType.emailAddress),
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
              const SizedBox(
                height: 40,
              ),
              TextButtonWidget(
                  buttonText: AppStrings.register,
                  textStyle: TextStyles.textStyleRegular16White,
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      // _login(emailController.text, passwordController.text);
                    }
                  }),
              const SizedBox(
                height: 80,
              ),
              // if(MediaQuery.viewInsetsOf(context).bottom==0)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.alreadyRegistered,
                        style: TextStyles.textStyleRegular16Grey
                            .copyWith(height: 1.5)),
                    GestureDetector(
                      onTap: () {
                        NavigationUtils.pushReplacement(context: context,page: SignInScreen());

                        // Navigator.pushReplacementNamed(
                        //     context, Routes.signInScreen);
                      },
                      child: Text(AppStrings.signIn,
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
    passwordController.dispose();
    emailController.dispose();
    fullNameController.dispose();
    super.dispose();
  }
}
