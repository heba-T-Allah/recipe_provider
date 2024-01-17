
import 'package:flutter/material.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_style.dart';

class PrepTimeAndServing extends StatelessWidget {
  const PrepTimeAndServing({
    super.key,
    required this.serving,
    required this.prepTime
  });

  final int serving ;
  final int prepTime;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Row(
          children: [
            Image.asset(
              ImageAssets.timeIcon,
              width: 16,
              height: 16,
              color: ColorManager.greyText,
            ),
            Text(
              "  ${prepTime / 60} Min",
              style: TextStyles.textStyleRegular10Grey,
            )
          ],
        ),
        Row(
          children: [
            Image.asset(
              ImageAssets.servingIcon,
              width: 16,
              height: 16,
              color: ColorManager.greyText,
            ),
            Text(
              "  $serving Serving",
              style: TextStyles.textStyleRegular10Grey,
            )
          ],
        ),
      ],
    );
  }
}