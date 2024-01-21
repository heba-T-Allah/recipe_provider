import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import '../../../model/recipe.dart';
import '../../../utils/toast_msg_status.dart';
import '../../widgets/overlay_custom_toast.dart';

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
      // var data = await rootBundle.loadString('assets/data/sample.json');
      // var adsDataDecoded =
      //     List<Map<String, dynamic>>.from(jsonDecode(data)['ads']);
      // var recipeDataDecoded =
      //     List<Map<String, dynamic>>.from(jsonDecode(data)['recipe']);
      // adsList = adsDataDecoded.map((e) => RecipeAd.fromJson(e)).toList();
      // recipeList = recipeDataDecoded.map((e) => Recipe.fromJson(e)).toList();
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
}
