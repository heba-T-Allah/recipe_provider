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
    return Stack(
      children: [
        Positioned(
          child: Card(
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
                      MyFavIcon(favourite: recipe.favorite!),
                      const SizedBox(
                        width: AppSize.s90,
                        height: AppSize.s90,
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
              )),
        ),
        Positioned(
          right: -7,
          top: -20,
          child: Image.asset(
            recipe.image!,
            width: AppSize.s150,
            height: AppSize.s150,
          ),
        ),
      ],
    );
  }
}
