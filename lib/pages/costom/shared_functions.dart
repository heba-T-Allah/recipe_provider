import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:registration/routing/routes.dart';
import 'package:registration/services/preferences.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedFunctions {
  final BuildContext? context;

  const SharedFunctions({required this.context});

  void showInSnackBar(String? value) {
    ScaffoldMessenger.of(context!)
        .showSnackBar(SnackBar(content: Text(value!)));
  }

  void logoutUser() async {
    GetIt.I.get<SharedPreferences>().clear();
    // PreferencesService.clearSharedPreferences();
    Navigator.pushReplacementNamed(context!, Routes.signInScreen);
  }
}
