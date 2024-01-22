import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../model/recipe.dart';

class RecentlyViewedProvider extends ChangeNotifier {
  List<Recipe> _recentlyViewedList = [];

  List<Recipe> get recentlyViewedList => _recentlyViewedList;

  set recentlyViewedList(List<Recipe> value) {
    _recentlyViewedList = value;
    notifyListeners();
  }

  void getRecentlyViewedRecipes() async {
    try {
      var data = await rootBundle.loadString('assets/data/sample.json');

      var recipeDataDecoded =
          List<Map<String, dynamic>>.from(jsonDecode(data)['recipe']);
      recentlyViewedList =
          recipeDataDecoded.map((e) => Recipe.fromJson(e)).toList();
    } catch (e) {}
  }
}
