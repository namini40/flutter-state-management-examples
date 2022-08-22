import 'dart:convert';
import 'package:set_state/constants.dart';
import 'package:set_state/weather.dart';
import 'package:http/http.dart' as http;

// this is a simplified class for handling api requests just to present as network layer
// a lot of details and implementations ignored assuming you know how to handle it.
class ApiHandler {
  String _createUrlUsingLocation(double lat, double lon) =>
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat.3&lon=$lon&appid=$apiKeyOpenWeatherMap';

  String _createUrlUsingCityName(String cityName) =>
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKeyOpenWeatherMap';

  // values are latitude and longitude which are obtained from device's GPS service
  // no error handling implemented here

  Future<Weather> getWeatherByLocation(double lat, double lon) async {
    final response =
        await http.get(Uri.parse(_createUrlUsingLocation(lat, lon)));
    final body = jsonDecode(response.body);
    final weather =
        Weather(double.parse(body['main']['temp']), body['weather'][0]['main']);
    return weather;
  }

  Future<Weather> getWeatherByCityName(String cityName) async {
    final response =
        await http.get(Uri.parse(_createUrlUsingCityName(cityName)));
    final body = jsonDecode(response.body);
    final weather =
        Weather(double.parse(body['main']['temp']), body['weather'][0]['main']);
    return weather;
  }
}
