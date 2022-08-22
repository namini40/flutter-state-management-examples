import 'package:flutter/material.dart';

void main() {
  runApp(SetStateExampleApp());
}

class SetStateExampleApp extends StatefulWidget {
  const SetStateExampleApp({Key? key}) : super(key: key);

  @override
  State<SetStateExampleApp> createState() => _SetStateExampleAppState();
}

class _SetStateExampleAppState extends State<SetStateExampleApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setState state management example app'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'no location or city name entered',
            style: TextStyle(fontSize: 26),
          ),
          ElevatedButton(
              onPressed: () {}, child: Text('get Weather by Location')),
          TextField(decoration: InputDecoration(hintText: 'city name')),
          ElevatedButton(
              onPressed: () {}, child: Text('get Weather by City Name')),
        ],
      ),
    );
  }
}
