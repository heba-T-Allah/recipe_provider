import 'package:flutter/material.dart';

import 'package:registration/pages/home/widgets/fresh_card_recipe.dart';
import '../../../model/recipe.dart';


class FreshRecipeList extends StatelessWidget {
  const FreshRecipeList({
    super.key,
    required this.recipeList,
  });

  final List<Recipe> recipeList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/3,
      child: ListView.builder(
        itemCount: recipeList.length,
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {

          return FreshCardRecipe(recipe: recipeList[index],screen: "fresh",);
        },
      ),
    );
  }
}
