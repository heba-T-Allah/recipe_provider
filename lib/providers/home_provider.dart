import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
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

  get filterValue => _filterValue;

  set filterValue(value) {
    _filterValue = value;
    print(filterValue);
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

  double? _selectedValue;

  double? get selectedValue => _selectedValue;

  set selectedValue(double? value) {
    _selectedValue = value;
    notifyListeners();
  }

  Future<void> getFilteredRecipes() async {
    try {
      var ref = FirebaseFirestore.instance.collection("recipe");
      var filteredData;
      for (var entry in filterValue.entries) {
        if(entry.key=="meal_type") {
          filteredData=await ref.where(entry.key, isEqualTo: entry.value);
        } else {
          filteredData=  await  ref.where(entry.key, isLessThanOrEqualTo: entry.value);
        }
      }
      var result = await filteredData.get();
      if (result.docs.isNotEmpty) {
        filteredList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
        // print("${filterValue} filteredd ");
        // print("${filteredList?.length} filteredd  ${filteredList?.first.title}");
      } else {
        filteredList = [];
      }
      notifyListeners();
      filterValue={};
    } catch (e) {
      filteredList = [];
      filterValue={};
      print(e);
      notifyListeners();
      OverlayToastMessage.show(
          widget: OverlayCustomToast(
        message: "Error: $e",
        status: ToastMessageStatus.failed,
      ));
    }
  }

  Future<void> getAllRecipes() async {
    try {
      var result = await FirebaseFirestore.instance.collection("recipe").get();
      if (result.docs.isNotEmpty) {
        recipeList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
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

  Future<void> getFreshRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection("recipe")
          .where('is_fresh', isEqualTo: true)
          .limit(5)
          .get();
      if (result.docs.isNotEmpty) {
        freshRecipeList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
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

  Future<void> getRecommendedRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection("recipe")
          .where('is_fresh', isEqualTo: false)
          .limit(5)
          .get();
      if (result.docs.isNotEmpty) {
        recommendedRecipeList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
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

  Future<void> addFavToRecipe(
      String recipeId, bool isAdd, String listType) async {
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
        getRecommendedRecipes();
      } else if (listType == "fresh") {
        getFreshRecipes();
      } else if (listType == "fav") {
        getFavoriteRecipes();
      } else if (listType == "recipe") {
        getFreshRecipes();
        getRecommendedRecipes();
        getAllRecipes();
      } else if (listType == "allRecipe") {
        getFreshRecipes();
        getRecommendedRecipes();
        getAllRecipes();
      } else {
        getAllRecipes();
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

  Future<void> getFavoriteRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection("recipe")
          .where('users_ids',
              arrayContains: FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (result.docs.isNotEmpty) {
        favRecipeList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
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
}
