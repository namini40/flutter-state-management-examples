import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../networking/api_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _cityName = '';
  String _message = 'no location or city name entered';
  final _apiHandler = ApiHandler();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('setState state management example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                _message,
                style: TextStyle(fontSize: 26),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                  onPressed: _onGetByLocationPressed,
                  child: Text('get Weather by Location')),
              TextField(
                decoration: InputDecoration(hintText: 'city name'),
                onChanged: (t) {
                  _cityName = t;
                },
              ),
              ElevatedButton(
                  onPressed: _onGetByCityNamePressed,
                  child: Text('get Weather by City Name')),
            ],
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

      setState(() {
        _message =
            'Weather:\ntemp: ${weather.temperature} F\nstatus: ${weather.status}';
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

      setState(() {
        _message =
            'Weather:\ntemp: ${weather.temperature} F\nstatus: ${weather.status}';
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
