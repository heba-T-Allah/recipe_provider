import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/pages/drawer/menu_screen.dart';
import 'package:registration/pages/widgets/skelton.dart';
import 'package:registration/providers/home_provider.dart';
import 'package:registration/resources/strings_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../app_bar/my_app_bar.dart';
import '../home/widgets/recommended_list.dart';
import '../home/widgets/search_and_filter.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
   await Future.delayed(Duration(seconds: 1));
    await Provider.of<HomeProvider>(context, listen: false)
        .getFavoriteRecipes();
    Provider.of<HomeProvider>(context,listen: false).haveResult = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      drawer: MenuScreen(
        onPageSelected: (p0) {},
      ),
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
              SearchAndFilter(
                screen: "favorite",

              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              Consumer<HomeProvider>(
                builder: (context, value, child) {
                  if(!value.haveResult){
                  if (value.favRecipeList == null) {
                    // If favRecipeList is null, return the Skeletonizer
                    return Skeletonizer(
                        enabled: true, child:
                    ListView.builder(itemCount:3,
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                          return Skelton();
                    },),
                    );
                  } else if (value.favRecipeList!.isEmpty) {
                    // If favRecipeList is empty, show "No Data Found" message
                    return Text('No Data Found');
                  } else {
                    // If favRecipeList has data, show the list of recommended recipes
                    return RecommendedRecipeList(
                        recipeList: value.favRecipeList!, screen: "fav");
                  }
                  }else{
                     if (value.updatedRecipeList.isEmpty) {
                      // If favRecipeList is empty, show "No Data Found" message
                      return Text('No Data Found');
                    } else {
                      // If favRecipeList has data, show the list of recommended recipes

                      return RecommendedRecipeList(
                          recipeList: value.updatedRecipeList, screen: "fav");
                    }



                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
