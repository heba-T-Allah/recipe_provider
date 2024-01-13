import 'package:flutter/material.dart';

import '../../../resources/strings_manager.dart';
import '../../../resources/text_style.dart';

class CardsTitle extends StatelessWidget {
  final String? title;

  CardsTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: TextStyles.textStyleBold18Black,
        ),
        Text(
          AppStrings.seeAll,
          style: TextStyles.textStyleMedium14Orange,
        )
      ],
    );
  }
}
