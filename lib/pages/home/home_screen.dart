import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/pages/drawer/menu_screen.dart';
import 'package:registration/pages/home/widgets/cards_title.dart';
import 'package:registration/pages/home/widgets/fresh_recipe_list.dart';
import 'package:registration/pages/home/widgets/my_carousel_slider.dart';
import 'package:registration/pages/home/widgets/recommended_list.dart';
import 'package:registration/pages/home/widgets/search_and_filter.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../app_bar/my_app_bar.dart';
import '../../providers/home_provider.dart';

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
    await Provider.of<HomeProvider>(context, listen: false).getFreshRecipes();
    await Provider.of<HomeProvider>(context, listen: false)
        .getRecommendedRecipes();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String userName =
        FirebaseAuth.instance.currentUser?.displayName.toString() ?? "No name";
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      drawer: MenuScreen(onPageSelected: (p0) {

      },),
      body: Consumer<HomeProvider>(builder: (context, value, child) {
        return value.freshRecipeList == null
            ? const Center(child: CircularProgressIndicator())
            : value.freshRecipeList!.isEmpty
                ? const Text('No Data Found')
                : Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p8,
                        left: AppPadding.p20,
                        right: AppPadding.p20),
                    child: SingleChildScrollView(
                      child: value.freshRecipeList!.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: AppSize.s20,
                                  child: Text(
                                    "Bonjour $userName",
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
                                 SearchAndFilter(screen: "home"),
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
                                FreshRecipeList(
                                    recipeList: value.freshRecipeList!),
                                const SizedBox(
                                  height: AppSize.s20,
                                ),
                                CardsTitle(title: AppStrings.recommended),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                value.recommendedRecipeList == null
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : value.recommendedRecipeList!.isEmpty
                                        ? const Text('No Data Found')
                                        : RecommendedRecipeList(
                                            recipeList:
                                                value.recommendedRecipeList!,screen: "recommended",),
                              ],
                            ),
                    ),
                  );
      }),
    );
  }
}
