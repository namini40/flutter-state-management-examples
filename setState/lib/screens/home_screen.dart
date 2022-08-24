import 'package:flutter/material.dart';
import 'package:set_state/models/weather.dart';
import 'package:set_state/screens/location_screen.dart';
import 'package:set_state/utils/database.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _message = 'no location or city name entered';

  @override
  void initState() {
    super.initState();
    _reloadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setState'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            _message,
            style: TextStyle(fontSize: 26),
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, LocationScreen.id)
                    .then((value) async {
                  await _reloadWeather();
                });
              },
              child: Text('Get New Data'))
        ],
      ),
    );
  }

  Future<void> _reloadWeather() async {
    Weather? weather = await Database.readWeather();
    if (weather != null) {
      setState(() {
        _message = weather.toString();
      });
    }
  }
}
