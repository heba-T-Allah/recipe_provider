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

  Future<void> getRecipes() async {
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
}
