import 'package:flutter/material.dart';
import 'package:registration/pages/see_all_recipe/see_all_recipe_screen.dart';
import 'package:registration/utils/navigation.dart';

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
        InkWell(
          onTap: () => NavigationUtils.push(
              context: context, page: SeeAllRecipeScreen()),
          child: Text(
            AppStrings.seeAll,
            style: TextStyles.textStyleMedium14Orange,
          ),
        )
      ],
    );
  }
}
