import 'package:flutter/material.dart';
import 'package:registration/view/home/widgets/prep_time_and_serving.dart';

import '../../../model/recipe.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_style.dart';
import '../../../resources/values_manager.dart';
import 'my_fav_icon.dart';
import 'my_rating_bar.dart';

class FreshCardRecipe extends StatelessWidget {
  const FreshCardRecipe({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(right: AppMargin.m60),
        color: ColorManager.backgroundGreyColor,
        elevation: 2,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s30),
            borderSide: BorderSide.none),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .50,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    MyFavIcon(favourite: recipe.favorite!),
                    Transform.translate(
                      offset: Offset(70, 0),
                      child: Image.asset(
                        recipe.image!,
                        height:AppSize.s120,
                        width: AppSize.s120,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),

                Text(
                  recipe.mealType!,
                  style: TextStyles.textStyleMedium10Blue,
                ),
                const SizedBox(
                  height: AppSize.s5,
                ),
                Flexible(
                  child: Text(recipe.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyles.textStyleMedium14Black),
                ),
                const SizedBox(
                  height: AppSize.s5,
                ),
                MyRatingBar(
                  rate: recipe.rating!,
                ),
                const SizedBox(
                  height: AppSize.s5,
                ),
                Text(
                  "${recipe.calories!} Calories",
                  style: TextStyles.textStyleRegular10Orange,
                ),
                const SizedBox(
                  height: AppSize.s5,
                ),
                PrepTimeAndServing(
                    prepTime: recipe.prepTime!, serving: recipe.serving!),
              ],
            ),
          ),
        ));
  }
}
