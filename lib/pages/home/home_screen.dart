import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/generated/l10n.dart';
import 'package:registration/pages/drawer/menu_screen.dart';
import 'package:registration/pages/home/widgets/cards_title.dart';
import 'package:registration/pages/home/widgets/fresh_recipe_list.dart';
import 'package:registration/pages/home/widgets/my_carousel_slider.dart';
import 'package:registration/pages/home/widgets/recommended_list.dart';
import 'package:registration/pages/home/widgets/search_and_filter.dart';
import 'package:registration/providers/update_profile_provider.dart';
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

  init() async {}

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false).getFreshRecipes(context);
    Provider.of<HomeProvider>(context, listen: false)
        .getRecommendedRecipes(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      drawer: MenuScreen(
        context: context,
        onPageSelected: (p0, p1) {},
      ),
      body: Consumer<HomeProvider>(builder: (context, value, child) {
        return value.freshRecipeList == null
            ? const Center(child: CircularProgressIndicator())
            : value.freshRecipeList!.isEmpty
                ? Text(S.of(context).NoDataFound)
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
                                    "${S.of(context).Bonjour} ${Provider.of<UpdateProfileProvider>(context, listen: false).getUserName()}",
                                    style: TextStyles.textStyleRegular13Grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                Text(
                                  S.of(context).whatWouldYouLikeToCook,
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
                                CardsTitle(title: S.of(context).todayFresh),
                                const SizedBox(
                                  height: AppSize.s20,
                                ),
                                FreshRecipeList(
                                    recipeList: value.freshRecipeList!),
                                const SizedBox(
                                  height: AppSize.s20,
                                ),
                                CardsTitle(title: S.of(context).recommended),
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
                                                value.recommendedRecipeList!,
                                            screen: "recommended",
                                          ),
                              ],
                            ),
                    ),
                  );
      }),
    );
  }
}
