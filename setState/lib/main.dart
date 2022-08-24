import 'package:flutter/material.dart';
import 'package:set_state/screens/home_screen.dart';
import 'package:set_state/screens/location_screen.dart';
import 'package:set_state/screens/splash_screen.dart';

void main() {
  runApp(SetStateExampleApp());
}

class SetStateExampleApp extends StatelessWidget {
  const SetStateExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (_) => SplashScreen(),
        HomeScreen.id: (_) => HomeScreen(),
        LocationScreen.id: (_) => LocationScreen()
      },
    );
  }
}
