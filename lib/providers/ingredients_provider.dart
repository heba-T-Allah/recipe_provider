import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:registration/model/ingredient.dart';
import '../utils/toast_msg_status.dart';
import '../pages/widgets/overlay_custom_toast.dart';

class IngredientsProvider extends ChangeNotifier {
  List<Ingredient>? _ingredientList;

  List<Ingredient>? get ingredientList => _ingredientList;

  set ingredientList(List<Ingredient>? value) {
    _ingredientList = value;
    notifyListeners();
  }

  BuildContext? context;
  Future<void> getIngredients(BuildContext context) async {
    this.context = context;
    try {
      var result =
          await FirebaseFirestore.instance.collection("ingredient").get();
      if (result.docs.isNotEmpty) {
        ingredientList = List<Ingredient>.from(result.docs
            .map((doc) => Ingredient.fromJson(doc.data(), context, doc.id)));
      } else {
        ingredientList = [];
      }
      notifyListeners();
    } catch (e) {
      ingredientList = [];
      print(e);
      notifyListeners();
      OverlayToastMessage.show(
          widget: OverlayCustomToast(
        message: "Error: $e",
        status: ToastMessageStatus.failed,
      ));
    }
  }

  Future<void> addIngredientToUser(String ingredientId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('ingredient')
            .doc(ingredientId)
            .update({
          "users_ids":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('ingredient')
            .doc(ingredientId)
            .update({
          "users_ids":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      OverlayLoadingProgress.stop();
      getIngredients(this.context!);
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
          widget: OverlayCustomToast(
        message: "Error: $e",
        status: ToastMessageStatus.failed,
      ));
    }
  }

  List<Ingredient>? _searchResultIngredientList;

  List<Ingredient>? get searchResultIngredientList =>
      _searchResultIngredientList;

  set searchResultIngredientList(List<Ingredient>? value) {
    _searchResultIngredientList = value;
    notifyListeners();
  }

  bool haveResult = false;

  void searchIngredients(String keyword) {
    List<Ingredient> result = [];

    if (keyword.isEmpty) {
      result = ingredientList!;
    } else {
      result = ingredientList!
          .where((ingredient) => {ingredient.name}
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    }
    searchResultIngredientList = result;

    haveResult = true;
    notifyListeners();
  }
}
