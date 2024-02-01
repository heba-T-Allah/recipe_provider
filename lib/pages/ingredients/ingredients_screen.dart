import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/model/ingredient.dart';
import 'package:registration/providers/ingredients_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../app_bar/my_app_bar.dart';
import '../home/widgets/search_and_filter.dart';
import '../widgets/no_data_found_widget.dart';

class IngredientsScreen extends StatefulWidget {
  IngredientsScreen({super.key});

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await Future.delayed(const Duration(seconds: 1));
    await Provider.of<IngredientsProvider>(context, listen: false)
        .getIngredients();
    Provider.of<IngredientsProvider>(context, listen: false).haveResult = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: MyAppBar(),
        body: Padding(
          padding: const EdgeInsets.only(
              top: AppPadding.p8, left: AppPadding.p20, right: AppPadding.p20),
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(AppStrings.ingredients,
                    style: TextStyles.textStyleRegular26Black),
                const SizedBox(
                  height: AppSize.s10,
                ),
                SearchAndFilter(
                  screen: "ingredients",
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Consumer<IngredientsProvider>(
                    builder: (context, ingredientsProvider, child) {
                  if (!ingredientsProvider.haveResult) {
                    if (ingredientsProvider.ingredientList == null) {
                      return Skeletonizer(
                          enabled: true, child: skeltonWidget());
                    } else if (ingredientsProvider.ingredientList!.isEmpty) {
                      return const NoDataFoundWidget();
                    } else {
                      return listData(ingredientsProvider,
                          ingredientsProvider.ingredientList!);
                    }
                  } else {
                    if (ingredientsProvider.searchResultIngredientList ==
                        null) {
                      return Skeletonizer(
                        enabled: true,
                        child: skeltonWidget(),
                      );
                    } else if (ingredientsProvider
                        .searchResultIngredientList!.isEmpty) {
                      return const NoDataFoundWidget();
                    } else {
                      return listData(ingredientsProvider,
                          ingredientsProvider.searchResultIngredientList!);
                    }
                  }
                }),
              ])),
        ));
  }

  Padding listData(IngredientsProvider ingredientsProvider,
      List<Ingredient> ingredientList) {
    return Padding(
        padding: const EdgeInsets.only(
            top: AppPadding.p8, left: AppPadding.p20, right: AppPadding.p20),
        child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: ingredientList.length,
            itemBuilder: (ctx, index) => ListTile(
                  leading: Checkbox(
                    checkColor: ColorManager.backgroundGreyColor,
                    activeColor: ColorManager.primaryColor,
                    value: ingredientList[index]
                        .users_ids
                        ?.contains(FirebaseAuth.instance.currentUser?.uid),
                    onChanged: (value) async {
                      await ingredientsProvider.addIngredientToUser(
                          ingredientList[index].docId!, value ?? false);
                    },
                  ),
                  title: Text(ingredientList[index].name ?? 'No Name'),
                )));
  }

  ListView skeltonWidget() {
    return ListView.builder(
      itemCount: 3,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: ColorManager.backgroundGreyColor,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("data")
            ],
          ),
        );
      },
    );
  }
}
