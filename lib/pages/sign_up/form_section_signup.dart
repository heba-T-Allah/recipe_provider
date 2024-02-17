import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/generated/l10n.dart';
import 'package:registration/resources/strings_manager.dart';

import '../../resources/text_style.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/text_button_widget.dart';
import '../../providers/signup_provider.dart';

class FormSectionSignUp extends StatefulWidget {
  const FormSectionSignUp({super.key});

  @override
  State<FormSectionSignUp> createState() => _FormSectionSignUpState();
}

class _FormSectionSignUpState extends State<FormSectionSignUp> {
  @override
  void initState() {
    Provider.of<SignUpProvider>(context, listen: false).init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (BuildContext context, SignUpProvider provider, Widget? child) =>
          Form(
              key: provider.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: CustomTextFormField(
                          controller: provider.fullNameController!,
                          hintForMsg: AppStrings.nameHintText,
                          hintText: S.of(context).fullNameHintText,
                          prefixIcon: Icons.person,
                          obsecureType: false,
                          isObsecureText: false,
                          inputType: TextInputType.text),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: CustomTextFormField(
                          hintForMsg: AppStrings.emailHintText,
                          controller: provider.emailController!,
                          hintText: S.of(context).emailHintText,
                          prefixIcon: Icons.email,
                          obsecureType: false,
                          isObsecureText: false,
                          inputType: TextInputType.emailAddress),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: CustomTextFormField(
                          hintForMsg: AppStrings.password,
                          controller: provider.passwordController!,
                          hintText: S.of(context).password,
                          prefixIcon: Icons.lock,
                          obsecureType: true,
                          isObsecureText: true,
                          inputType: TextInputType.visiblePassword),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextButtonWidget(
                        buttonText: S.of(context).register,
                        textStyle: TextStyles.textStyleRegular16White,
                        onPressed: () {
                          provider.signUp(context);
                        }),
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(S.of(context).alreadyRegistered,
                              style: TextStyles.textStyleRegular16Grey
                                  .copyWith(height: 1.5)),
                          GestureDetector(
                            onTap: () {
                              provider.openSigninScreen(context);
                            },
                            child: Text(S.of(context).signIn,
                                style: TextStyles.textStyleRegular16Orange
                                    .copyWith(height: 1.5)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
    );
  }

  @override
  void dispose() {
    if (context.mounted) {
      Provider.of<SignUpProvider>(context, listen: false).providerDispose();
    }
    super.dispose();
  }
}
