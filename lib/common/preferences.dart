//TODO usar para salvar infos do usuario e de preferencias

import 'package:shared_preferences/shared_preferences.dart';

enum PreferencesKeys {
  accessToken("acess_token"),
  userData("user_data"),
  firebaseToken("firebase_token");

  final String value;
  const PreferencesKeys(this.value);
}

class Preferences {
  static void storeFirebaseToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.firebaseToken.value, value);
  }

  static Future<String?> getFirebaseToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferencesKeys.firebaseToken.value);
  }
}
