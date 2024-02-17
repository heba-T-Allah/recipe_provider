import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registration/generated/l10n.dart';

import '../../../model/recipe.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/text_style.dart';
import '../../../resources/values_manager.dart';
import '../../home/widgets/my_fav_icon.dart';
import '../../home/widgets/my_rating_bar.dart';
import '../../widgets/row_custom_icon_and_image.dart';

class RecipeSpecifications extends StatelessWidget {
  RecipeSpecifications({super.key, required this.recipe});

  Recipe recipe;

  bool? isFav;

  @override
  Widget build(BuildContext context) {
    isFav =
        recipe.favUsersIds?.contains(FirebaseAuth.instance.currentUser?.uid);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipe.mealType!,
          style: TextStyles.textStyleRegular12Blue,
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(recipe.title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyles.textStyleBold22Black),
            ),
            MyFavIcon(isFav: isFav, docId: recipe.docId, listType: "recipe"),
          ],
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        Text(
          "${recipe.calories!} ${S.of(context).calorie}",
          style: TextStyles.textStyleMedium14Orange,
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        MyRatingBar(
          rate: recipe.rating!,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RowIconAndText(
                    title: " ${recipe.prepTime!} ${S.of(context).min}",
                    icon: ImageAssets.timeIcon,
                    iconSize: 30,
                    textStyle: TextStyles.textStyleRegular13Grey,
                  ),
                  const SizedBox(
                    height: AppSize.s30,
                  ),
                  RowIconAndText(
                    title: "  ${recipe.serving!} ${S.of(context).servingNum}",
                    icon: ImageAssets.servingIcon,
                    iconSize: 30,
                    textStyle: TextStyles.textStyleRegular13Grey,
                  ),
                ],
              ),
              CachedNetworkImage(
                  imageUrl: recipe.image!,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageBuilder: (context, image) => CircleAvatar(
                        backgroundImage: NetworkImage(
                          recipe.image!,
                        ),
                        radius: 80,
                      )),
            ],
          ),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
      ],
    );
  }
}
