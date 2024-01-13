import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../../routing/routes.dart';

class TextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final TextStyle textStyle;

  const TextButtonWidget({
    super.key,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p30, vertical: AppPadding.p8),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: AppPadding.p8)),
          backgroundColor: MaterialStateProperty.all(ColorManager.primaryColor),
          minimumSize:
              MaterialStateProperty.all(const Size(double.infinity, 60)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        ),
        child: Text(
          buttonText,
          style: textStyle,
        ),
      ),
    );
  }
}
