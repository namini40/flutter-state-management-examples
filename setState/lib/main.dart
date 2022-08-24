import 'package:flutter/material.dart';
import 'package:set_state/screens/splash_screen.dart';

void main() {
  runApp(SetStateExampleApp());
}

class SetStateExampleApp extends StatelessWidget {
  const SetStateExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
