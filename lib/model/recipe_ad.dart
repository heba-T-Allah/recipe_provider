import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/providers/setting_provider.dart';

class RecipeAd {
  String? id;
  String? title;
  String? image;

  RecipeAd();

  RecipeAd.fromJson(Map<String, dynamic> data, BuildContext context,
      [String? docId]) {
    String local =
        Provider.of<SettingProvider>(context, listen: false).getLocal();

    title = (local == "ar") ? data['title-ar'] : data['title'];
    image = data['image'];
    id = docId;
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "image": image,
    };
  }
}
