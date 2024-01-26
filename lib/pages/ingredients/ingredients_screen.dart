import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/providers/ingredients_provider.dart';

import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../app_bar/my_app_bar.dart';
import '../home/widgets/search_and_filter.dart';

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
    await Provider.of<IngredientsProvider>(context, listen: false)
        .getIngredients();
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
                const SearchAndFilter(),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Consumer<IngredientsProvider>(
                  builder: (context, ingredientsProvider, child) =>
                      ingredientsProvider.ingredientList == null
                          ? const Center(child: CircularProgressIndicator())
                          : ingredientsProvider.ingredientList!.isEmpty
                              ? const Text('No Data Found')
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: AppPadding.p8,
                                      left: AppPadding.p20,
                                      right: AppPadding.p20),
                                  child: ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: ingredientsProvider
                                          .ingredientList!.length,
                                      itemBuilder: (ctx, index) => ListTile(
                                            leading: Checkbox(
                                              checkColor: ColorManager.backgroundGreyColor,
                                              activeColor: ColorManager.primaryColor,
                                              value: ingredientsProvider
                                                  .ingredientList![index]
                                                  .users_ids
                                                  ?.contains(FirebaseAuth
                                                      .instance
                                                      .currentUser
                                                      ?.uid),
                                              onChanged: (value) async {
                                                await ingredientsProvider
                                                    .addIngredientToUser(
                                                        ingredientsProvider
                                                            .ingredientList![
                                                                index]
                                                            .docId!,
                                                        value ?? false);
                                              },
                                            ),
                                            title: Text(ingredientsProvider
                                                    .ingredientList![index]
                                                    .name ??
                                                'No Name'),
                                          ))),
                ),
              ])),
        ));
  }
}
