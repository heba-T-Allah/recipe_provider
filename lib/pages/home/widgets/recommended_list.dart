import 'package:flutter/material.dart';
import '../../../model/recipe.dart';
import 'recommended_card.dart';


class RecommendedRecipeList extends StatelessWidget {
  const RecommendedRecipeList({
    super.key,
    required this.recipeList,
  });

  final List<Recipe> recipeList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.of(context).size.height * .4,
      child: ListView.builder(
        itemCount: recipeList.length,
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * .27,
            child: RecommendedCard(recipe: recipeList[index]),
          );
        },
      ),
    );
  }
}
