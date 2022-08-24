import 'package:flutter/material.dart';
import 'package:set_state/screens/location_screen.dart';

import '../networking/api_handler.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

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
              onPressed: () {
                Navigator.pushNamed(context, LocationScreen.id);
              },
              child: Text('Get New Data'))
        ],
      ),
    );
  }
}
