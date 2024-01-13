import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    var preference = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(preference);
    // if (PreferencesService.prefs != null) {
    //   print("preferences init successfully ");
    // }
  } catch (e) {
    print("can't init preferences ${e} ");
  }

  runApp( MyApp());
}
