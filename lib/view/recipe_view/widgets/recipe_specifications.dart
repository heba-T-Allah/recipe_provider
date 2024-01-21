
import 'package:flutter/material.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/text_style.dart';
import '../../../resources/values_manager.dart';
import '../../home/widgets/my_fav_icon.dart';
import '../../home/widgets/my_rating_bar.dart';
import '../../widgets/row_custom_icon_and_image.dart';

class RecipeSpecifications extends StatelessWidget {
  const RecipeSpecifications({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "lunch",
          // recipe!.mealType!,
          style: TextStyles.textStyleRegular12Blue,
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("eggs",
                // recipe!.title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyles.textStyleBold22Black),
            MyFavIcon(favourite: false),
          ],
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        Text(
          "33 Calories",

          // "${recipe!.calories!} Calories",
          style: TextStyles.textStyleMedium14Orange,
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        MyRatingBar(rate: 4
          // recipe!.rating!,
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
                    title: " 3 mins",
                    icon: ImageAssets.timeIcon,
                    iconSize: 30,
                    textStyle: TextStyles.textStyleRegular13Grey,
                  ),
                  const SizedBox(
                    height: AppSize.s30,
                  ),
                  RowIconAndText(
                    title:"  3 Serving",
                    icon: ImageAssets.servingIcon,
                    iconSize: 30,
                    textStyle: TextStyles.textStyleRegular13Grey,
                  ),

                ],
              ),
              Transform.translate(
                offset: Offset(80, -40),
                child: Image.asset(
                  "assets/images/brown-eggs.jpg",
                  width: 200,
                  height: 200,
                ),
              ),
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
