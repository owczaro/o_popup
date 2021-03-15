import 'package:flutter/material.dart';
import 'package:o_popup/o_popup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'o_popup demo app',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _withHeaderContentAndActionRowDismissible(context),
              SizedBox(height: 10.0),
              _withHeaderContentAndActionRow(context),
              SizedBox(height: 10.0),
              _withGraphicalContent(context),
            ],
          ),
        ),
      );

  OPopupTrigger _withHeaderContentAndActionRowDismissible(
          BuildContext context) =>
      OPopupTrigger(
        barrierAnimationDuration: Duration(milliseconds: 400),
        triggerWidget: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.amber,
          child: Text('Dismissible popup with header, content and action row'),
        ),
        popupHeader: OPopupContent.standardizedHeader('Some header'),
        popupContent: OPopupContent.standardizedText(
          'Click anywhere to close the popup. If you press back button, popup '
          'closes itself into opening place',
        ),
        popupActionRow: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                textStyle: TextStyle(color: Colors.white),
              ),
              child: Text('Yes'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                textStyle: TextStyle(color: Colors.white),
              ),
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );

  OPopupTrigger _withHeaderContentAndActionRow(BuildContext context) =>
      OPopupTrigger(
        barrierAnimationDuration: Duration(milliseconds: 400),
        barrierDismissible: false,
        triggerWidget: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.amber,
          child: Text('Popup with header, content and action row'),
        ),
        popupHeader: OPopupContent.standardizedHeader('Some header'),
        popupContent: OPopupContent.standardizedText(
          'You can close this popup only by clicking one of actions in the '
          'action row. If you press back button, popup closes itself '
          'into opening place',
        ),
        popupActionRow: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                textStyle: TextStyle(color: Colors.white),
              ),
              child: Text('Yes'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                textStyle: TextStyle(color: Colors.white),
              ),
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );

  OPopupTrigger _withGraphicalContent(BuildContext context) => OPopupTrigger(
        barrierAnimationDuration: Duration(milliseconds: 400),
        triggerWidget: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.amber,
          child:
              Text('Dismissible popup with graphical content and action row'),
        ),
        popupContent: Container(
          width: 50.0,
          height: 50.0,
          color: Colors.amber,
        ),
        popupActionRow: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                textStyle: TextStyle(color: Colors.white),
              ),
              child: Text('Like'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                textStyle: TextStyle(color: Colors.white),
              ),
              child: Text('Dislike'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
}
