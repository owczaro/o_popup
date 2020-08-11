import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class OTestGestures {
  static Future<void> doTapUp(WidgetTester tester, Offset downLocation) async {
    final TestGesture gesture = await tester.startGesture(downLocation);
    await gesture.up();
  }
}
