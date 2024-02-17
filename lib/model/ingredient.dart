import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/providers/setting_provider.dart';

class Ingredient {
  String? docId;
  String? name;
  List<String>? users_ids;

  Ingredient();

  Ingredient.fromJson(Map<String, dynamic> data, BuildContext context,
      [String? id]) {
    String local =
        Provider.of<SettingProvider>(context, listen: false).getLocal();
    docId = id;
    name = (local == "ar") ? data['name_ar'] : data['name'];
    users_ids = data['users_ids'] != null
        ? List<String>.from(data['users_ids'].map((e) => e.toString()))
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "users_ids": users_ids,
    };
  }
}
