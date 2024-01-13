import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../model/recipe.dart';

class FavoriteProvider extends ChangeNotifier{
  List<Recipe> _favoriteList = [];

  List<Recipe> get favoriteList => _favoriteList;

  set favoriteList(List<Recipe> value) {
    _favoriteList = value;
    notifyListeners();
  }

  void getFavoriteRecipes() async {
    try {
      var data = await rootBundle.loadString('assets/data/sample.json');

      var recipeDataDecoded =
      List<Map<String, dynamic>>.from(jsonDecode(data)['recipe']);
      List<Recipe> recipeList =
      recipeDataDecoded.map((e) => Recipe.fromJson(e)).toList();
      favoriteList = recipeList.where((e) => e.favorite!).toList();
    } catch (e) {
    }
  }
}