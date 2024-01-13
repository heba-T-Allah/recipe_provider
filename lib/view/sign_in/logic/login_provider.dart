import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../resources/strings_manager.dart';
import '../../../utils/navigation.dart';
import '../../home/home_screen.dart';

class LoginProvider extends ChangeNotifier {
  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      await GetIt.I
          .get<SharedPreferences>()
          .setString(AppStrings.emailPref, email);
      GetIt.I
          .get<SharedPreferences>()
          .setString(AppStrings.passwordPref, password);
      GetIt.I.get<SharedPreferences>().setBool(AppStrings.isLoggedInPref, true);
      print("login Successfully.");
      NavigationUtils.pushReplacement(context: context, page: HomeScreen());
      notifyListeners();
    } on Exception catch (e) {}
  }
}
