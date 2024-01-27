import 'package:flutter/material.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/text_style.dart';
import '../../widgets/row_custom_icon_and_image.dart';

class PrepTimeAndServing extends StatelessWidget {
  const PrepTimeAndServing(
      {super.key, required this.serving, required this.prepTime});

  final int serving;

  final int prepTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RowIconAndText(
          title: "  $prepTime  Min  ",
          icon: ImageAssets.timeIcon,
          iconSize: 14,
          textStyle: TextStyles.textStyleRegular10Grey,
        ),
        RowIconAndText(
          title: "  $serving Serving",
          icon: ImageAssets.servingIcon,
          iconSize: 14,
          textStyle: TextStyles.textStyleRegular10Grey,
        ),
      ],
    );
  }
}
