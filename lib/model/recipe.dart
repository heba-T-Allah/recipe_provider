import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/providers/setting_provider.dart';

class Recipe {
  String? docId;
  String? title;
  String? image;
  String? mealType;
  double? rating;
  double? calories;
  int? prepTime;
  int? serving;

  List<dynamic>? ingredients;
  List<dynamic>? directions;
  List<String>? favUsersIds;
  List<String>? recentlyViewUid;

  Recipe();

  Recipe.fromJson(Map<String, dynamic> data, BuildContext context,
      [String? id]) {
    String local =
        Provider.of<SettingProvider>(context, listen: false).getLocal();
    docId = id;
    title = (local == "ar") ? data['title_ar'] : data['title'];
    image = data['image'];
    mealType = (local == "ar") ? data['meal_type_ar'] : data['meal_type'];
    rating = double.parse(data['rating'].toString());
    calories = double.parse(data['calories'].toString());
    prepTime = data['prep_time'];
    serving = data['serving'];
    directions = (local == "ar")
        ? data['directions_ar'].map((e) => e.toString()).toList()
        : data['directions'].map((e) => e.toString()).toList();
    ingredients = (local == "ar")
        ? data['ingredients_ar'].map((e) => e.toString()).toList()
        : data['ingredients'].map((e) => e.toString()).toList();
    favUsersIds = data['users_ids'] != null
        ? List<String>.from(data['users_ids'].map((e) => e.toString()))
        : null;
    recentlyViewUid = data['recently_view_uid'] != null
        ? List<String>.from(data['recently_view_uid'].map((e) => e.toString()))
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "image": image,
      "meal_type": mealType,
      'rating': rating,
      'calories': calories,
      'prep_time': prepTime,
      'serving': serving,
      'directions': directions,
      'ingredients': ingredients,
      "users_ids": favUsersIds,
      'recently_view_uid': recentlyViewUid
    };
  }
}
