import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/pages/drawer/menu_screen.dart';
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
    await Provider.of<HomeProvider>(context, listen: false)
        .getFavoriteRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      drawer: MenuScreen(onPageSelected: (p0) {
        
      },),
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
              Consumer<HomeProvider>(builder: (context, value, child) {
                return  Skeletonizer(
                    enabled: value.favRecipeList == null,child:value.favRecipeList!.isEmpty
                    ? const Text('No Data Found'): RecommendedRecipeList(recipeList: value.favRecipeList!,screen: "fav",));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
