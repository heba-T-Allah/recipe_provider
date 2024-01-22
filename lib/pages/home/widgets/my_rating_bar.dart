import 'package:flutter/material.dart';
import '../../../resources/color_manager.dart';

class MyRatingBar extends StatelessWidget {
  const MyRatingBar({super.key, required this.rate});

  final double rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          rate >= 1 ? Icons.star : Icons.star_border,
          color: ColorManager.primaryColor,
        ),
        Icon(
          rate >= 2 ? Icons.star : Icons.star_border,
          color: rate < 2 ? ColorManager.greyText : ColorManager.primaryColor,
        ),
        Icon(
          rate >= 3 ? Icons.star : Icons.star_border,
          color: rate < 3 ? ColorManager.greyText : ColorManager.primaryColor,
        ),
        Icon(
          rate >= 4 ? Icons.star : Icons.star_border,
          color: rate < 4 ? ColorManager.greyText : ColorManager.primaryColor,
        ),
        Icon(
          rate == 5 ? Icons.star : Icons.star_border,
          color: rate < 5 ? ColorManager.greyText : ColorManager.primaryColor,
        ),
        // RatingBar.builder(
        //   initialRating: recipeList[index].rating!,
        //   minRating: 1,
        //   direction: Axis.horizontal,
        //   allowHalfRating: true,
        //   itemCount: 5,
        //   itemBuilder: (context, _) => Icon(
        //     Icons.star,
        //     color: ColorManager.primaryColor,
        //   ),
        //   onRatingUpdate: (rating) {
        //     print(rating);
        //   },
        // ),
      ],
    );
  }
}
