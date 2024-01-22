import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../resources/color_manager.dart';

class RowIconAndText extends StatelessWidget {
  RowIconAndText(
      {super.key,
      required this.icon,
      required this.iconSize,
      required this.title,
      required this.textStyle});

  String icon;
  double iconSize;
  String title;
  TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon,
          width: iconSize,
          height: iconSize,
          color: ColorManager.greyText,
        ),
        Text(
          title,
          style: textStyle,
        )
      ],
    );
  }
}
