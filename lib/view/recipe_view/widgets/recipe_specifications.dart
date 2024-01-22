import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
            MyFavIcon(favourite: recipe.favorite!),
          ],
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        Text(
          "${recipe.calories!} Calories",
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
                    title: " ${recipe.prepTime!} mins",
                    icon: ImageAssets.timeIcon,
                    iconSize: 30,
                    textStyle: TextStyles.textStyleRegular13Grey,
                  ),
                  const SizedBox(
                    height: AppSize.s30,
                  ),
                  RowIconAndText(
                    title: "  ${recipe.serving!} Serving",
                    icon: ImageAssets.servingIcon,
                    iconSize: 30,
                    textStyle: TextStyles.textStyleRegular13Grey,
                  ),
                ],
              ),
              Transform.translate(
                  offset: Offset(80, -40),
                  child:
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      recipe.image!,
                    ),
                    radius: 100,
                  )),
              // CachedNetworkImage(
              //   height: 100,
              //   width: 100,
              //   imageUrl:  recipe.image!,
              //   placeholder: (context, url) => CircularProgressIndicator(),
              //
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              // ),)
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
