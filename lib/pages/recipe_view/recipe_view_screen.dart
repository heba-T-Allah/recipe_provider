import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:registration/generated/l10n.dart';
import 'package:registration/model/ingredient.dart';
import 'package:registration/pages/recipe_view/widgets/recipe_specifications.dart';
import 'package:registration/providers/home_provider.dart';
import '../../model/recipe.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../../utils/toast_msg_status.dart';
import '../app_bar/my_app_bar.dart';
import '../widgets/overlay_custom_toast.dart';

class RecipeViewScreen extends StatefulWidget {
  RecipeViewScreen({super.key, required this.recipe});

  Recipe? recipe;

  @override
  State<RecipeViewScreen> createState() => _RecipeViewScreenState();
}

class _RecipeViewScreenState extends State<RecipeViewScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await Provider.of<HomeProvider>(context, listen: false)
        .addToRecentRecipe(widget.recipe!.docId!, true);
    print("recipe viewed");
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: MyAppBar(
          backbtn: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecipeSpecifications(recipe: widget.recipe!),
                Text(
                  S.of(context).ingredients,
                  style: TextStyles.textStyleBold18Black,
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("ingredient")
                        .where("users_ids",
                            arrayContains:
                                FirebaseAuth.instance.currentUser?.uid)
                        .get(),
                    builder: (context, snapShot) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        if (snapShot.hasError) {
                          return OverlayToastMessage.show(
                              widget: OverlayCustomToast(
                            message: S.of(context).errorWhenGetData,
                            status: ToastMessageStatus.failed,
                          ));
                        } else {
                          if (snapShot.hasData) {
                            List<Ingredient> userIngredients = snapShot
                                .data!.docs
                                .map((e) => Ingredient.fromJson(
                                    e.data(), context, e.id))
                                .toList();
                            var userIngredientsTitles =
                                userIngredients.map((e) => e.name).toList();
                            Widget _checkIngregient(String recipeIngredient) {
                              bool isExsit = false;
                              for (var userIngredientTitle
                                  in userIngredientsTitles) {
                                if (recipeIngredient
                                    .contains(userIngredientTitle!)) {
                                  isExsit = true;
                                  break;
                                } else {
                                  isExsit = false;
                                }
                              }

                              if (isExsit) {
                                return Icon(
                                  Icons.check,
                                  color: Colors.green,
                                );
                              } else {
                                return Icon(
                                  Icons.close,
                                  color: Colors.red,
                                );
                              }
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: widget.recipe!.ingredients!.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _checkIngregient(
                                        widget.recipe!.ingredients![index]),
                                    Flexible(
                                      child: Text(
                                        " ${widget.recipe!.ingredients![index]}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style:
                                            TextStyles.textStyleRegular16Black,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return OverlayToastMessage.show(
                                widget: OverlayCustomToast(
                              message: S.of(context).NoDataFound,
                              status: ToastMessageStatus.success,
                            ));
                          }
                        }
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  S.of(context).directions,
                  style: TextStyles.textStyleBold18Black,
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: widget.recipe!.directions!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "• ${S.of(context).Step} ${index + 1}:",
                            style: TextStyles.textStyleRegular16Orange,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "• ${widget.recipe!.directions![index]}",
                                maxLines: 7,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.textStyleRegular16Black,
                              )),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
