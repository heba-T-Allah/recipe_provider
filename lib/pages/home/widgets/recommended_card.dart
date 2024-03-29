import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:registration/generated/l10n.dart';

import 'package:registration/pages/home/widgets/prep_time_and_serving.dart';

import '../../../model/recipe.dart';
import '../../../providers/home_provider.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_style.dart';
import '../../../resources/values_manager.dart';
import '../../../utils/navigation.dart';
import '../../recipe_view/recipe_view_screen.dart';
import 'my_fav_icon.dart';
import 'my_rating_bar.dart';

class RecommendedCard extends StatelessWidget {
  RecommendedCard({super.key, required this.recipe, required this.screen});

  final Recipe recipe;

  bool? isFav;
  String? screen;

  @override
  Widget build(BuildContext context) {
    isFav =
        recipe.favUsersIds?.contains(FirebaseAuth.instance.currentUser?.uid);
    return InkWell(
      onTap: () => NavigationUtils.push(
          context: context,
          page: RecipeViewScreen(
            recipe: recipe,
          )),
      child: Card(
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
          color: ColorManager.backgroundGreyColor,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s30),
              borderSide: BorderSide.none),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                child: CachedNetworkImage(
                  imageUrl: recipe.image!,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: NetworkImage(
                        recipe.image!,
                      ),
                      radius: AppSize.s30),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(recipe.mealType!,
                            style: TextStyles.textStyleMedium10Blue),
                        const SizedBox(
                          height: AppSize.s8,
                        ),
                        Text(recipe.title!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyles.textStyleMedium14Black),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.p8),
                          child: Row(
                            children: [
                              MyRatingBar(
                                rate: recipe.rating!,
                              ),
                              const SizedBox(
                                width: AppSize.s10,
                              ),
                              Text(
                                "${recipe.calories!} ${S.of(context).calorie}",
                                style: TextStyles.textStyleRegular10Orange,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: AppSize.s10,
                        ),
                        PrepTimeAndServing(
                            prepTime: recipe.prepTime!,
                            serving: recipe.serving!),
                      ]),
                ),
              ),
              screen == "recentlyView"
                  ? IconButton(
                      onPressed: () async {
                        await Provider.of<HomeProvider>(context, listen: false)
                            .addToRecentRecipe(recipe.docId!, false);
                        print("recipe removed");
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.red,
                      ))
                  : MyFavIcon(
                      isFav: isFav, docId: recipe.docId, listType: screen),
            ],
          )),
    );
  }
}
