
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';

class SkeltonSeeAll extends StatelessWidget {
  SkeltonSeeAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.favorite),

                    CircleAvatar(
                      radius: 40,
                      ),
                  ],
                ),
                Text(""
                ),
                const SizedBox(
                  height: AppSize.s5,
                ),
                Text("dddddddddd"),
                const SizedBox(
                  height: AppSize.s5,
                ),

                Text(" Calories",
                ),
                const SizedBox(
                  height: AppSize.s5,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("recipe.prepTime"), Text("data")],
                ),             ],
            ),
          ),
        ));
  }
}
