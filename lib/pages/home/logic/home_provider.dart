import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../model/recipe.dart';

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
      // OverlayToastMessage.show(
      //     widget: OverlayCustomToast(
      //       message: "Error: $e",
      //       status: ToastMessageStatus.failed,
      //     ));
    }
  }

  Future<void> getFreshRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection("recipe")
          .where('is_fresh', isEqualTo: true)
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
      // OverlayToastMessage.show(
      //     widget: OverlayCustomToast(
      //       message: "Error: $e",
      //       status: ToastMessageStatus.failed,
      //     ));
    }
  }

  Future<void> getRecommendedRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection("recipe")
          .where('is_fresh', isEqualTo: false)
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
      // OverlayToastMessage.show(
      //     widget: OverlayCustomToast(
      //       message: "Error: $e",
      //       status: ToastMessageStatus.failed,
      //     ));
    }
  }
}
