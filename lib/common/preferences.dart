//TODO usar para salvar infos do usuario e de preferencias

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    var getUserDataPrefs = jsonDecode(await prefs.getString('userdata')!);
    final Map<String, dynamic> userData = jsonDecode(getUserDataPrefs);
    return userData;
  }

  storeUserData(String key, String value) async {
    if (value.isNotEmpty && key.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(key, json.encode(value));
    }
  }

  removeUserData(String key) async {
    if (key.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(key);
    }
  }

  // static Future<UserData> getUserData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var data = prefs.getString(PreferencesKeys.userData.value);
  //
  //   if (data != null) {
  //     return UserData.fromJson(data);
  //   }
  //
  //   return UserData();
  // }
}
