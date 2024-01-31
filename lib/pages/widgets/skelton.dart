
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';

class Skelton extends StatelessWidget {
  Skelton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

        color: ColorManager.backgroundGreyColor,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s30),
            borderSide: BorderSide.none),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                child: CircleAvatar(
                  backgroundColor: ColorManager.backgroundGreyColor,
                  radius: 40,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text("meal type"),
                  Text("recipe Title"),
                  Text(" Calories"),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("recipe.prepTime"), Text("data")],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
