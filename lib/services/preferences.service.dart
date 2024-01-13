// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../resources/strings_manager.dart';
//
// abstract class PreferencesService {
//   static SharedPreferences? prefs;
//
//   static getSharedPreferences() async {
//     try {
//       prefs = await SharedPreferences.getInstance();
//       if (prefs != null) {
//         print("preferences init successfully ");
//       }
//     } catch (e) {
//       print("can't init preferences ${e} ");
//     }
//   }
//
//   static saveStringValue(String key, String value) async {
//     // _getSharedPreferences();
//     prefs?.setString(key, value);
//   }
//
//   static Future<String?> retrieveStringValue(String key) async {
//     // _getSharedPreferences();
//     String? value = prefs?.getString(key);
//     print(await value);
//     return value;
//   }
//
// //islogged in
//   static saveBoolValue(bool value) async {
//     // _getSharedPreferences();
//     prefs?.setBool(AppStrings.isLoggedInPref, value);
//   }
//
//   static bool retrieveBoolValueIsLoggedIn()  {
//     // _getSharedPreferences();
//     bool value = prefs?.getBool(AppStrings.isLoggedInPref) ?? false;
//     print(value);
//     return value;
//   }
//
//   static void clearSharedPreferences() async {
//     // _getSharedPreferences();
//     prefs?.clear();
//     print("shared preferences cleared");
//   }
// }
