import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/model/recipe.dart';
import 'package:registration/pages/home/widgets/fresh_card_recipe.dart';
import 'package:registration/providers/home_provider.dart';
import 'package:registration/resources/strings_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../app_bar/my_app_bar.dart';
import '../home/widgets/search_and_filter.dart';
import '../widgets/skelton_see_all.dart';

class SeeAllRecipeScreen extends StatefulWidget {
  SeeAllRecipeScreen({super.key});

  @override
  State<SeeAllRecipeScreen> createState() => _SeeAllRecipeScreenState();
}

class _SeeAllRecipeScreenState extends State<SeeAllRecipeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  init() async {
    await Future.delayed(Duration(seconds: 1));
    await Provider.of<HomeProvider>(context, listen: false).getAllRecipes();
    Provider.of<HomeProvider>(context, listen: false).haveResult = false;
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
              SearchAndFilter(screen: "allRecipe"),
              const SizedBox(
                height: AppSize.s10,
              ),
              Consumer<HomeProvider>(builder: (context, value, child) {
                if (!value.haveResult) {
                  if (value.recipeList == null) {
                    return Skeletonizer(
                      enabled: true,
                      child: skeltonGridView(),
                    );
                  } else if (value.recipeList!.isEmpty) {
                    return const Text('No Data Found');
                  } else {
                    return buildFlexibleGridView(
                        value, context, value.recipeList!);
                  }
                } else {
                  if (value.updatedRecipeList.isEmpty) {
                    return const Text('No Data Found');
                  } else {
                    return buildFlexibleGridView(
                        value, context, value.updatedRecipeList);
                  }
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  FlexibleGridView buildFlexibleGridView(
      HomeProvider provider, BuildContext context, List<Recipe> recipeList) {
    return FlexibleGridView(
      shrinkWrap: true,
      children: recipeList
          .map(
            (e) => SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: FreshCardRecipe(recipe: e, screen: "allRecipe"),
            ),
          )
          .toList(),
      axisCount: GridLayoutEnum.twoElementsInRow,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
    );
  }

  FlexibleGridView skeltonGridView() {
    return FlexibleGridView(
        shrinkWrap: true,
        axisCount: GridLayoutEnum.twoElementsInRow,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: [
          SkeltonSeeAll(),
          SkeltonSeeAll(),
          SkeltonSeeAll(),
          SkeltonSeeAll()
        ]);
  }
}
