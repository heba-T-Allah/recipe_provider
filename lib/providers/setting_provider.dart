import 'dart:async';

import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  Locale _local = Locale('en');
  String? sharedLang;
  Future<void> getlang() async {
    var prefs = await SharedPreferences.getInstance();
    sharedLang = prefs.getString('locale');
    print("/////////////////// ${prefs.getString('locale')}");
  }

  Locale get local {
    getlang();

    if (sharedLang == "العربيه") {
      local = Locale('ar');
    } else {
      local = Locale('en');
    }

    return _local;
  }

  set local(Locale value) {
    _local = value;
  }

  String getLocal() {
    getlang();
    if (local == Locale('ar')) {
      return "ar";
    } else if (local == Locale('en')) {
      return "en";
    } else {
      return "en";
    }
  }

  void setLocal(String lang) async {
    OverlayLoadingProgress.start();

    if (lang == "العربيه") {
      local = Locale('ar');
    } else {
      local = Locale('en');
    }
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("locale", lang);

    notifyListeners();
    OverlayLoadingProgress.stop();
  }
}
