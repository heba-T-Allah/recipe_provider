import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registration/view/recipe_view/widgets/recipe_specifications.dart';
import '../../model/recipe.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../app_bar/my_app_bar.dart';


class RecipeViewScreen extends StatelessWidget {
  RecipeViewScreen({super.key,required this.recipe});

  Recipe? recipe;

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: MyAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RecipeSpecifications(recipe:recipe!),
              SizedBox(
                height: AppSize.s20,
              ),
              Text(
                AppStrings.ingredients,
                style: TextStyles.textStyleBold18Black,
              ),
              Text(
                AppStrings.directions,
                style: TextStyles.textStyleBold18Black,
              ),
            ],
          ),
        ));
  }
}
