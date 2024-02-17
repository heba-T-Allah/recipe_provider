import 'package:flutter/material.dart';
import 'package:registration/generated/l10n.dart';
import 'package:registration/resources/color_manager.dart';
import 'package:registration/resources/text_style.dart';
import '../../resources/strings_manager.dart';
import '../../utils/app_regex.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.hintForMsg,
      required this.prefixIcon,
      required this.obsecureType,
      required this.isObsecureText,
      required this.inputType});

  final TextEditingController controller;
  final String hintText;
  final String hintForMsg;

  final IconData prefixIcon;
  bool obsecureType;
  bool isObsecureText;
  final TextInputType inputType;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  // bool isObsecureText = true;

  void toggleObsecure() {
    widget.isObsecureText = !widget.isObsecureText;
    setState(() {});
  }

  String _errorMsg(String str) {
    switch (widget.hintForMsg) {
      case AppStrings.nameHintText:
        return S.of(context).nameIsEmpty;
      case AppStrings.emailHintText:
        return S.of(context).emailIsEmpty;
      case AppStrings.password:
        return S.of(context).passwordIsEmpty;
      default:
        return S.of(context).fieldIsEmpty;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.always,
        style: TextStyles.textStyleRegular16Grey,
        keyboardType: widget.inputType,
        controller: widget.controller,
        obscureText: widget.isObsecureText,
        decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            label: Text(
              widget.hintText,
              style: TextStyles.textStyleRegular14Grey,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManager.primaryColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManager.greyBorder),
            ),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: ColorManager.greyText,
            ),
            suffixIcon: widget.obsecureType
                ? InkWell(
                    onTap: () => toggleObsecure(),
                    child: Icon(
                      widget.isObsecureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: ColorManager.greyText,
                    ),
                  )
                : null),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return _errorMsg(widget.hintText);
          }
          if (widget.hintText == S.of(context).emailHintText) {
            if (!AppRegex.isEmailValid(value)) {
              return S.of(context).notValidEmail;
            }
          }
          if (widget.hintText == S.of(context).password) {
            if (value == null ||
                value.isEmpty ||
                !AppRegex.isPasswordValid(value)) {
              return S.of(context).pleaseEnterValidPassword;
            }
          }
        });
  }
}
