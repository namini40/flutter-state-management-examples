import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:set_state/utils/database.dart';

import '../networking/api_handler.dart';

class LocationScreen extends StatefulWidget {
  static const id = 'location_screen';

  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _message = 'no actions yet!';
  String _cityName = '';

  final _apiHandler = ApiHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(_message, style: TextStyle(fontSize: 18)),
                ElevatedButton(
                  onPressed: _onGetByLocationPressed,
                  child: Text('Get By Location'),
                ),
                Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: 'City name here!'),
                      onChanged: (t) {
                        _cityName = t;
                      },
                    ),
                    ElevatedButton(
                        onPressed: _onGetByCityNamePressed,
                        child: Text('Get By City Name'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _onGetByLocationPressed() async {
    setState(() {
      _message = 'loading...';
    });
    Position position = await _determinePosition();
    try {
      final weather = await _apiHandler.getWeatherByLocation(
          position.latitude, position.longitude);
      await Database.saveWeather(weather);
      setState(() {
        _message = weather.toString();
      });
    } catch (e) {
      print(e);
      setState(() {
        _message =
            'an error occurred!\nplease check your net connection and inputs and try again';
      });
    }
  }

  Future<void> _onGetByCityNamePressed() async {
    setState(() {
      _message = 'loading...';
    });

    try {
      final weather = await _apiHandler.getWeatherByCityName(_cityName);
      await Database.saveWeather(weather);
      setState(() {
        _message = weather.toString();
      });
    } catch (e) {
      print(e);
      setState(() {
        _message =
            'an error occurred!\nplease check your net connection and inputs and try again';
      });
    }
  }
}
