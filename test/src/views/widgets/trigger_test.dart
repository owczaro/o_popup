import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:o_popup/o_popup.dart';

import '../../../helpers/gestures.dart';

/// Tests [OPopupTrigger]

// TODO: check layoutTree like in overlay flutter tests
void main() {
  group('[Views/Widgets] OPopupTrigger', () {
    testWidgets('Works correctly', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(800.0, 800.0);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);

      final popupKey = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Builder(
              builder: (BuildContext context) {
                return OPopupTrigger(
                  key: popupKey,
                  barrierDismissible: false,
                  barrierColor: Colors.black.withOpacity(0.1),
                  barrierAnimationDuration: const Duration(milliseconds: 150),
                  triggerWidget: Text('Some text'), // or any [Widget]
                  popupHeader: OPopupContent.standardizedHeader(
                    'Header text here',
                  ), // or any [Widget]
                  popupContent: OPopupContent.standardizedText('Some content'),
                  popupActionRow: Row(
                    // or any [Widget]
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlineButton(
                        textColor: Colors.white,
                        child: Text('Yes'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      OutlineButton(
                        textColor: Colors.white,
                        child: Text('No'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Some text'));

      // barrierAnimationDuration: 150 ms
      await tester.pump(const Duration(milliseconds: 1));

      final Finder animatedModalBarrier = find.byType(AnimatedModalBarrier);
      Animation<Color> modalBarrierAnimation;
      modalBarrierAnimation =
          tester.widget<AnimatedModalBarrier>(animatedModalBarrier).color;

      expect(modalBarrierAnimation.isCompleted, equals(false));

      await tester.pump(const Duration(milliseconds: 149));
      expect(modalBarrierAnimation.isCompleted, equals(false));

      await tester.pump(const Duration(milliseconds: 2));
      expect(modalBarrierAnimation.isCompleted, equals(true));

      // Did popup shows?
      expect(animatedModalBarrier, findsOneWidget);
      expect(find.text('Header text here'), findsOneWidget);
      expect(find.text('Some content'), findsOneWidget);
      expect(find.text('Yes'), findsOneWidget);
      expect(find.text('No'), findsOneWidget);

      // Dismissible: false
      await OTestGestures.doTapUp(tester, const Offset(1.0, 1.0));
      expect(animatedModalBarrier, findsOneWidget);

      // BarrierColor
      expect(modalBarrierAnimation.value, Colors.black.withOpacity(0.1));
    });
  });
}
