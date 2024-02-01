import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:registration/providers/home_provider.dart';
import 'package:registration/resources/strings_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../model/recipe.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../../utils/toast_msg_status.dart';
import '../app_bar/my_app_bar.dart';
import '../home/widgets/recommended_list.dart';
import '../home/widgets/search_and_filter.dart';
import '../widgets/overlay_custom_toast.dart';
import '../widgets/skelton.dart';

class RecentlyViewedScreen extends StatefulWidget {
  RecentlyViewedScreen({super.key});

  @override
  State<RecentlyViewedScreen> createState() => _RecentlyViewedScreenState();
}

class _RecentlyViewedScreenState extends State<RecentlyViewedScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await Future.delayed(Duration(seconds: 1));
    Provider.of<HomeProvider>(context, listen: false).haveResult = false;
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
              Text(AppStrings.recentlyViewed,
                  style: TextStyles.textStyleRegular26Black),
              const SizedBox(
                height: AppSize.s10,
              ),
              SearchAndFilter(screen: 'recentlyView'),
              const SizedBox(
                height: AppSize.s10,
              ),
              Consumer<HomeProvider>(builder: (context, value, child) {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('recipe')
                        .where("recently_view_uid",
                            arrayContains:
                                FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapShots) {
                      if (snapShots.connectionState ==
                          ConnectionState.waiting) {
                        return Skeletonizer(
                          enabled: value.updatedRecipeList.isEmpty,
                          child: ListView.builder(
                            itemCount: 3,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Skelton();
                            },
                          ),
                        );
                      } else {
                        if (snapShots.hasError) {
                          return OverlayToastMessage.show(
                              widget: OverlayCustomToast(
                            message: "Error when get data",
                            status: ToastMessageStatus.failed,
                          ));
                        } else {
                          if (snapShots.hasData) {
                            List<Recipe> recipeList = snapShots.data!.docs
                                .map((e) => Recipe.fromJson(e.data(), e.id))
                                .toList();
                            value.recentlyViewedRecipe = recipeList;

                            if (value.haveResult) {
                              if (value.updatedRecipeList.isEmpty) {
                                return Text('No Data Found');
                              } else {
                                return RecommendedRecipeList(
                                  recipeList: value.updatedRecipeList,
                                  screen: "recentlyView",
                                );
                              }
                            } else {
                              if (recipeList.isEmpty) {
                                return Text('No Data Found');
                              } else {
                                return RecommendedRecipeList(
                                  recipeList: recipeList,
                                  screen: "recentlyView",
                                );
                              }
                            }
                          } else {
                            return OverlayToastMessage.show(
                                widget: OverlayCustomToast(
                              message: "There is No data found",
                              status: ToastMessageStatus.success,
                            ));
                          }
                        }
                      }
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
