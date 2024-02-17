import 'package:flutter/material.dart';
import 'package:registration/generated/l10n.dart';
import 'package:registration/pages/see_all_recipe/see_all_recipe_screen.dart';
import 'package:registration/utils/navigation.dart';
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              S.of(context).seeAll,
              style: TextStyles.textStyleMedium14Orange,
            ),
          ),
        )
      ],
    );
  }
}
