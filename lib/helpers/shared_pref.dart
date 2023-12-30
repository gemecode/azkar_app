import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // static const String _key = "exampleKey";

  // Save a string value to shared preferences
  static Future<bool> saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  // Retrieve a string value from shared preferences
  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
