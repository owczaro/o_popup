import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:o_popup/src/views/widgets/modal_barrier_gesture_detector.dart';

/// Tests [OModalBarrierGestureDetector]

void main() {
  group('[Views/Widgets] OModalBarrierGestureDetector', () {
    testWidgets('Detects onTapUp', (tester) async {
      var tapUpCount = 0;

      await tester.pumpWidget(
        Container(
          alignment: Alignment.topLeft,
          child: Container(
            alignment: Alignment.topLeft,
            height: 100.0,
            color: Colors.blue,
            child: OModalBarrierGestureDetector(
              child: Container(
                width: 10.0,
                height: 10.0,
                color: Colors.red,
              ),
              onTapUp: (details) {
                tapUpCount += 1;
              },
            ),
          ),
        ),
      );

      await tester.tapAt(const Offset(1.0, 1.0));
      expect(tapUpCount, 1);

      await tester.tapAt(const Offset(11.0, 11.0));
      expect(tapUpCount, 1);

      await tester.tapAt(const Offset(0.0, 0.0));
      expect(tapUpCount, 2);
    });
  });
}
