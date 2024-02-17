import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:registration/generated/l10n.dart';
import '../model/recipe.dart';
import '../utils/toast_msg_status.dart';
import '../pages/widgets/overlay_custom_toast.dart';

class HomeProvider extends ChangeNotifier {
  List<Recipe>? _recipeList;

  List<Recipe>? get recipeList => _recipeList;

  set recipeList(List<Recipe>? value) {
    _recipeList = value;
    notifyListeners();
  }

  List<Recipe>? _freshRecipeList;

  List<Recipe>? get freshRecipeList => _freshRecipeList;

  set freshRecipeList(List<Recipe>? value) {
    _freshRecipeList = value;
    notifyListeners();
  }

  List<Recipe>? _recommendedRecipeList;

  List<Recipe>? get recommendedRecipeList => _recommendedRecipeList;

  set recommendedRecipeList(List<Recipe>? value) {
    _recommendedRecipeList = value;
    notifyListeners();
  }

  List<Recipe>? _favRecipeList;

  List<Recipe>? get favRecipeList => _favRecipeList;

  set favRecipeList(List<Recipe>? value) {
    _favRecipeList = value;
    notifyListeners();
  }

  List<Recipe>? _recentlyViewedRecipeList;

  List<Recipe>? get recentlyViewedRecipeList => _recentlyViewedRecipeList;

  set recentlyViewedRecipeList(List<Recipe>? value) {
    _recentlyViewedRecipeList = value;
    notifyListeners();
  }

  //filter map from ui
  var _filterValue = {};

  get filterSendValue => _filterValue;

  set filterSendValue(value) {
    _filterValue = value;
    print(filterSendValue);
    notifyListeners();
  }

//filtered list from firebase
//   var value = {"type": "breakfast", "serving": 4, "prep_time": 70};
  List<Recipe>? _filteredList;

  List<Recipe>? get filteredList => _filteredList;

  set filteredList(List<Recipe>? value) {
    _filteredList = value;
    notifyListeners();
  }

  Future<void> getFilteredRecipes() async {
    if (filterSendValue != null || !filterSendValue.isEmpty) {
      try {
        var ref = FirebaseFirestore.instance.collection("recipe");
        var filteredData;

        for (var entry in filterSendValue.entries) {
          if (entry.key == "meal_type") {
            filteredData = await ref.where(entry.key, isEqualTo: entry.value);
          } else if (entry.key == "meal_type_ar") {
            filteredData = await ref.where(entry.key, isEqualTo: entry.value);
          } else {
            filteredData =
                await ref.where(entry.key, isLessThanOrEqualTo: entry.value);
          }
        }
        if (filteredData != null) {
          var result = await filteredData.get();
          if (result.docs.isNotEmpty) {
            filteredList = List<Recipe>.from(result.docs
                .map((doc) => Recipe.fromJson(doc.data(), context!, doc.id)));
          } else {
            filteredList = [];
          }
          notifyListeners();
          filterSendValue = {};
        } else {
          filteredList = [];
        }
      } catch (e) {
        filteredList = [];
        filterSendValue = {};
        print("/////////////////$e");
        notifyListeners();
        // OverlayToastMessage.show(
        //     widget: OverlayCustomToast(
        //   message: "Error: $e",
        //   status: ToastMessageStatus.failed,
        // ));
      }
    } else {
      print("NoFilterDataEntered");
      OverlayToastMessage.show(
          widget: OverlayCustomToast(
        message: S.of(this.context!).NoFilterDataEntered,
        status: ToastMessageStatus.failed,
      ));
    }
  }

  BuildContext? context;
  Future<void> getAllRecipes(BuildContext context) async {
    this.context = context;
    try {
      var result = await FirebaseFirestore.instance.collection("recipe").get();
      if (result.docs.isNotEmpty) {
        recipeList = List<Recipe>.from(result.docs
            .map((doc) => Recipe.fromJson(doc.data(), context, doc.id)));
      } else {
        recipeList = [];
      }
      notifyListeners();
    } catch (e) {
      recipeList = [];
      print(e);
      notifyListeners();
      OverlayToastMessage.show(
          widget: OverlayCustomToast(
        message: "Error: $e",
        status: ToastMessageStatus.failed,
      ));
    }
  }

  Future<void> getFreshRecipes(BuildContext context) async {
    this.context = context;

    try {
      var result = await FirebaseFirestore.instance
          .collection("recipe")
          .where('is_fresh', isEqualTo: true)
          .limit(5)
          .get();
      if (result.docs.isNotEmpty) {
        freshRecipeList = List<Recipe>.from(result.docs
            .map((doc) => Recipe.fromJson(doc.data(), context, doc.id)));
      } else {
        freshRecipeList = [];
      }
      notifyListeners();
    } catch (e) {
      freshRecipeList = [];
      print(e);
      notifyListeners();
      OverlayToastMessage.show(
          widget: OverlayCustomToast(
        message: "Error: $e",
        status: ToastMessageStatus.failed,
      ));
    }
  }

  Future<void> getRecommendedRecipes(BuildContext context) async {
    this.context = context;

    try {
      var result = await FirebaseFirestore.instance
          .collection("recipe")
          .where('is_fresh', isEqualTo: false)
          .limit(5)
          .get();
      if (result.docs.isNotEmpty) {
        recommendedRecipeList = List<Recipe>.from(result.docs
            .map((doc) => Recipe.fromJson(doc.data(), context, doc.id)));
      } else {
        recommendedRecipeList = [];
      }
      notifyListeners();
    } catch (e) {
      recommendedRecipeList = [];
      print(e);
      notifyListeners();
      OverlayToastMessage.show(
          widget: OverlayCustomToast(
        message: "Error: $e",
        status: ToastMessageStatus.failed,
      ));
    }
  }

  Future<void> addFavToRecipe(String recipeId, bool isAdd, String listType,
      BuildContext context) async {
    this.context = context;

    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('recipe')
            .doc(recipeId)
            .update({
          "users_ids":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('recipe')
            .doc(recipeId)
            .update({
          "users_ids":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      notifyListeners();
      OverlayLoadingProgress.stop();
      if (listType == "recommended") {
        getRecommendedRecipes(context);
      } else if (listType == "fresh") {
        getFreshRecipes(context);
      } else if (listType == "fav") {
        getFavoriteRecipes(context);
      } else if (listType == "recipe") {
        getFreshRecipes(context);
        getRecommendedRecipes(context);
        getAllRecipes(context);
      } else if (listType == "allRecipe") {
        getFreshRecipes(context);
        getRecommendedRecipes(context);
        getAllRecipes(context);
      } else {
        getAllRecipes(context);
      }
      notifyListeners();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
          widget: OverlayCustomToast(
        message: "Error: $e",
        status: ToastMessageStatus.failed,
      ));
    }
  }

  Future<void> getFavoriteRecipes(BuildContext context) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection("recipe")
          .where('users_ids',
              arrayContains: FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (result.docs.isNotEmpty) {
        favRecipeList = List<Recipe>.from(result.docs
            .map((doc) => Recipe.fromJson(doc.data(), context, doc.id)));
      } else {
        favRecipeList = [];
      }
      notifyListeners();
    } catch (e) {
      favRecipeList = [];
      print(e);
      notifyListeners();
      OverlayToastMessage.show(
          widget: OverlayCustomToast(
        message: "Error: $e",
        status: ToastMessageStatus.failed,
      ));
    }
  }

  Future<void> addToRecentRecipe(String recipeId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('recipe')
            .doc(recipeId)
            .update({
          "recently_view_uid":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('recipe')
            .doc(recipeId)
            .update({
          "recently_view_uid":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      notifyListeners();
      OverlayLoadingProgress.stop();

      notifyListeners();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
          widget: OverlayCustomToast(
        message: "Error: $e",
        status: ToastMessageStatus.failed,
      ));
    }
  }

  List<Recipe> _updatedRecipeList = [];

  List<Recipe> get updatedRecipeList => _updatedRecipeList;

  set updatedRecipeList(List<Recipe> value) {
    _updatedRecipeList = value;
    notifyListeners();
  }

  bool haveResult = false;
  List<Recipe>? _recentlyViewedRecipe;

  List<Recipe>? get recentlyViewedRecipe => _recentlyViewedRecipe;

  set recentlyViewedRecipe(List<Recipe>? value) {
    _recentlyViewedRecipe = value;
    // notifyListeners();
  }

  void searchRecipe(String keyword, String screen) {
    List<Recipe> myRecipeList = [];
    List<Recipe> result = [];
    if (screen == "favorite") {
      myRecipeList = favRecipeList!;
    } else if (screen == "allRecipe") {
      myRecipeList = recipeList!;
    } else if (screen == "recentlyView") {
      myRecipeList = recentlyViewedRecipe!;
    }
    if (keyword.isEmpty) {
      result = myRecipeList;
    } else {
      result = myRecipeList
          .where((recipe) => {recipe.title}
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    }
    updatedRecipeList = result;

    haveResult = true;
    notifyListeners();
    print("-------------- - updatedRecipeList$updatedRecipeList");
  }
}
