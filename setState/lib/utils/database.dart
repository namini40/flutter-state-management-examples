import 'package:shared_preferences/shared_preferences.dart';

class Database {
  static const tempKey = 'temp';
  static const statusKey = 'status';

  static Future<void> saveToSharedPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<double?> readNumberFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static Future<String?> readTextFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
