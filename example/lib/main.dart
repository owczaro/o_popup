import 'package:flutter/material.dart';
import 'package:o_popup/o_popup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'o_popup test app',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: OPopupTrigger(
            triggerWidget: Text('Click me'),
            popupHeader: OPopupContent.standardizedHeader('Click anywhere'),
            popupContent: Container(
              width: 50.0,
              height: 50.0,
              color: Colors.blue,
            ),
          ),
        ),
      );
}
