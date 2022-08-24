import 'package:set_state/models/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  static const tempKey = 'temp';
  static const statusKey = 'status';

  static Future<void> saveStringToSharedPreferences(
      String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<void> saveNumberToSharedPreferences(
      String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  static Future<double?> readNumberFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static Future<String?> readTextFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> saveWeather(Weather weather) async {
    await saveNumberToSharedPreferences(tempKey, weather.temperature);
    await saveStringToSharedPreferences(statusKey, weather.status);
  }

  static Future<Weather?> getWeather() async {
    double? temp = await readNumberFromSharedPreferences(tempKey);
    String? status = await readTextFromSharedPreferences(statusKey);
    if (temp == null) {
      return null;
    } else {
      return Weather(temp, status);
    }
  }
}
