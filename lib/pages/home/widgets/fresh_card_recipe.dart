import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registration/utils/navigation.dart';
import 'package:registration/pages/home/widgets/prep_time_and_serving.dart';
import 'package:registration/pages/recipe_view/recipe_view_screen.dart';

import '../../../model/recipe.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_style.dart';
import '../../../resources/values_manager.dart';
import 'my_fav_icon.dart';
import 'my_rating_bar.dart';

class FreshCardRecipe extends StatelessWidget {
   FreshCardRecipe({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  bool? isFav;

  @override
  Widget build(BuildContext context) {
    isFav = recipe.favUsersIds
        ?.contains(FirebaseAuth.instance.currentUser?.uid);
    return InkWell(
      onTap: () => NavigationUtils.push(
          context: context,
          page: RecipeViewScreen(
            recipe: recipe,
          )),
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
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyFavIcon(isFav: isFav, docId: recipe.docId, listType: "fresh"),

                      Transform.translate(
                        offset: Offset(40, 0),
                        child: CachedNetworkImage(
                            imageUrl: recipe.image!,
                            placeholder: (context, url) => new CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            imageBuilder: (context, image) => CircleAvatar(
                                backgroundImage: NetworkImage(
                                   recipe.image!,
                                ),
                                radius: AppSize.s60)),
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
          )),
    );
  }
}
