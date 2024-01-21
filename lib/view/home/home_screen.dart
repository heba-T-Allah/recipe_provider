import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/view/drawer/my_drawer.dart';
import 'package:registration/view/home/widgets/cards_title.dart';
import 'package:registration/view/home/widgets/fresh_recipe_list.dart';
import 'package:registration/view/home/widgets/my_carousel_slider.dart';
import 'package:registration/view/home/widgets/recommended_list.dart';
import 'package:registration/view/home/widgets/search_and_filter.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../app_bar/my_app_bar.dart';
import 'logic/home_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    // Future.delayed(const Duration(milliseconds: 500), () {
    await Provider.of<HomeProvider>(context, listen: false).getRecipes();
    // });
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: Consumer<HomeProvider>(builder: (context, value, child) {
        return value.recipeList == null
            ? const Center(child: CircularProgressIndicator())
            : value.recipeList!.isEmpty
                ? const Text('No Data Found')
                : Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p8,
                        left: AppPadding.p20,
                        right: AppPadding.p20),
                    child: SingleChildScrollView(
                      child: value.recipeList!.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: AppSize.s20,
                                  child: Text(
                                    "Bonjour Emma",
                                    style: TextStyles.textStyleRegular13Grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                Text(
                                  AppStrings.whatWouldYouLikeToCook,
                                  style: TextStyles.textStyleAbrilRegular20Black
                                      .copyWith(height: 1.5),
                                ),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                const SearchAndFilter(),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                MyCarouselSlider(),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                CardsTitle(title: AppStrings.todayFresh),
                                const SizedBox(
                                  height: AppSize.s20,
                                ),
                                FreshRecipeList(recipeList: value.recipeList!),
                                const SizedBox(
                                  height: AppSize.s20,
                                ),
                                CardsTitle(title: AppStrings.recommended),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                RecommendedRecipeList(
                                    recipeList: value.recipeList!),
                              ],
                            ),
                    ),
                  );
      }),
    );
  }
}
