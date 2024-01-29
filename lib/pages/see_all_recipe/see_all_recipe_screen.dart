import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/pages/home/widgets/fresh_card_recipe.dart';
import 'package:registration/providers/home_provider.dart';
import 'package:registration/resources/strings_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../app_bar/my_app_bar.dart';
import '../home/widgets/search_and_filter.dart';

class SeeAllRecipeScreen extends StatefulWidget {
  SeeAllRecipeScreen({super.key});

  @override
  State<SeeAllRecipeScreen> createState() => _SeeAllRecipeScreenState();
}

class _SeeAllRecipeScreenState extends State<SeeAllRecipeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  init() async {
    await Provider.of<HomeProvider>(context, listen: false).getAllRecipes();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        backbtn: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: AppPadding.p8, left: AppPadding.p20, right: AppPadding.p20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.allRecipe,
                  style: TextStyles.textStyleRegular26Black),
              const SizedBox(
                height: AppSize.s10,
              ),
               SearchAndFilter(screen: "allRecipe",),
              const SizedBox(
                height: AppSize.s10,
              ),
              Consumer<HomeProvider>(builder: (context, value, child) {
                if (value.recipeList == null) {
                  return Skeletonizer(enabled: true, child: Text('Loading...'));
                } else if (value.recipeList!.isEmpty) {
                  return const Text('No Data Found');
                } else {
                  return FlexibleGridView(
                    shrinkWrap: true,
                    children: value.recipeList!
                        .map(
                          (e) => SizedBox(
                            height: MediaQuery.of(context).size.height / 4,
                            // width:
                            //     MediaQuery.of(context).size.width ,
                            child:
                                FreshCardRecipe(recipe: e, screen: "allRecipe"),
                          ),
                        )
                        .toList(),
                    axisCount: GridLayoutEnum.twoElementsInRow,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
