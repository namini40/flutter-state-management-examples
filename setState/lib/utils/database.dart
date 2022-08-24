import 'package:set_state/models/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  static const tempKey = 'temp';
  static const statusKey = 'status';

  static Future<void> saveWeather(Weather weather) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(tempKey, weather.temperature);
    await prefs.setString(statusKey, weather.status);
  }

  static Future<Weather?> readWeather() async {
    final prefs = await SharedPreferences.getInstance();
    double? temp = prefs.getDouble(tempKey);
    String? status = prefs.getString(statusKey);
    if (temp == null) {
      return null;
    } else {
      return Weather(temp, status!);
    }
  }
}
