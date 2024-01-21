import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../model/recipe.dart';
import '../../../model/recipe_ad.dart';


class HomeProvider extends ChangeNotifier {
  List<RecipeAd>? _adsList;

  List<Recipe>? _recipeList;

  CarouselController? buttonCarouselController;
  var currentPos = 0;

  List<RecipeAd>? get adsList => _adsList;

  set adsList(List<RecipeAd>? value) {
    _adsList = value;
    notifyListeners();
  }

  List<Recipe>? get recipeList => _recipeList;

  set recipeList(List<Recipe>? value) {
    _recipeList = value;
    notifyListeners();
  }



  Future<void> getAdsAndRecipes() async {
    try {
      var data = await rootBundle.loadString('assets/data/sample.json');
      var adsDataDecoded =
          List<Map<String, dynamic>>.from(jsonDecode(data)['ads']);
      var recipeDataDecoded =
          List<Map<String, dynamic>>.from(jsonDecode(data)['recipe']);
      adsList = adsDataDecoded.map((e) => RecipeAd.fromJson(e)).toList();
      recipeList = recipeDataDecoded.map((e) => Recipe.fromJson(e)).toList();
    } catch (e) {}
  }
}
