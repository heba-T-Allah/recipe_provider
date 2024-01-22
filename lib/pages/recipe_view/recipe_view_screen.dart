import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registration/pages/recipe_view/widgets/recipe_specifications.dart';
import '../../model/recipe.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../app_bar/my_app_bar.dart';

class RecipeViewScreen extends StatelessWidget {
  RecipeViewScreen({super.key, required this.recipe});

  Recipe? recipe;

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: MyAppBar(backbtn: true,),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecipeSpecifications(recipe: recipe!),
                Text(
                  AppStrings.ingredients,
                  style: TextStyles.textStyleBold18Black,
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: recipe!.ingredients!.length,
                    itemBuilder: (context, index) {
                      return Text(
                        "• ${recipe!.ingredients![index]}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyles.textStyleRegular16Black,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  AppStrings.directions,
                  style: TextStyles.textStyleBold18Black,
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: recipe!.directions!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "• Step ${index + 1}:",
                            style: TextStyles.textStyleMedium16Black,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "• ${recipe!.directions![index]}",
                                maxLines: 7,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.textStyleRegular16Black,
                              )),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
