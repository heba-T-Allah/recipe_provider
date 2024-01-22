import 'package:flutter/material.dart';
import '../../../resources/color_manager.dart';

class MyFavIcon extends StatelessWidget {
  const MyFavIcon({
    super.key,
    required this.favourite
  });

final bool favourite;
  @override
  Widget build(BuildContext context) {
    return Icon(
     favourite == true
          ? Icons.favorite
          : Icons.favorite_border,
      color: favourite == true
          ? ColorManager.primaryColor
          : ColorManager.greyText,
    );
  }
}
