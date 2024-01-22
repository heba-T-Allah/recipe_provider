import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/resources/strings_manager.dart';
import 'package:registration/pages/favorite/logic/favorite_provider.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../app_bar/my_app_bar.dart';
import '../drawer/my_drawer.dart';
import '../home/widgets/recommended_list.dart';
import '../home/widgets/search_and_filter.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(
            top: AppPadding.p8, left: AppPadding.p20, right: AppPadding.p20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.favorites,
                  style: TextStyles.textStyleRegular26Black),
              const SizedBox(
                height: AppSize.s10,
              ),
              const SearchAndFilter(),
              const SizedBox(
                height: AppSize.s10,
              ),
              Consumer<FavoriteProvider>(builder: (context, value, child) {
                return value.favoriteList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : RecommendedRecipeList(recipeList: value.favoriteList);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
