import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:o_popup/o_popup.dart';
import 'package:o_popup/src/models/convert_coordinates_to_alignment.dart';

import '../../../helpers/animations.dart';

/// Tests [OPopupOverlay]

void main() {
  group('[Views/Widgets] OPopupOverlay - default values', () {
    test('barrierColor (color field)', () {
      final overlay = OPopupOverlay(content: Text('Test'));

      expect(overlay.barrierColor, Colors.black.withOpacity(0.7));
    });

    test('transitionDuration (barrierAnimationDuration field)', () {
      final overlay = OPopupOverlay(content: Text('Test'));

      expect(overlay.transitionDuration, Duration(milliseconds: 200));
    });

    test('barrierDismissible (dismissible field)', () {
      final overlay = OPopupOverlay(content: Text('Test'));

      expect(overlay.barrierDismissible, isTrue);
    });

    test('barrierLabel', () {
      final overlay = OPopupOverlay(content: Text('Test'));

      expect(overlay.barrierLabel, isNull);
    });
  });

  group('[Views/Widgets] OPopupOverlay', () {
    final testWidget = MaterialApp(
      home: Material(
        child: Builder(
          builder: (context) {
            return Center(
              child: ElevatedButton(
                child: const Text('Open'),
                onPressed: () {
                  Navigator.of(context).push<void>(
                    OPopupOverlay(
                      dismissible: true,
                      color: Colors.blue,
                      barrierAnimationDuration:
                          const Duration(milliseconds: 200),
                      content: Container(
                        width: 10.0,
                        height: 10.0,
                        color: Colors.amber,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );

    testWidgets('Open', (tester) async {
      _setScreenSize(tester);
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Open'));
      await tester.pump();

      final animatedModalBarrier = find.byType(AnimatedModalBarrier);

      expect(animatedModalBarrier, findsOneWidget);
    });

    testWidgets('Close', (tester) async {
      _setScreenSize(tester);
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.tapAt(const Offset(12.12, 13.13));
      await tester.pump();

      expect(find.byType(AnimatedModalBarrier), findsNothing);
    });

    testWidgets('Transparent modal barrier at the beginning', (tester) async {
      _setScreenSize(tester);
      await tester.pumpWidget(testWidget);

      await tester.tap(find.text('Open'));
      await tester.pump();

      final animatedModalBarrier = find.byType(AnimatedModalBarrier);

      final modalBarrierAnimation =
          tester.widget<AnimatedModalBarrier>(animatedModalBarrier).color;
      expect(modalBarrierAnimation.value, Colors.blue.withOpacity(0));
    });

    testWidgets('Modal barrier becomes less transparent - 25%', (tester) async {
      _setScreenSize(tester);
      await tester.pumpWidget(testWidget);

      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      final animatedModalBarrier = find.byType(AnimatedModalBarrier);

      final modalBarrierAnimation =
          tester.widget<AnimatedModalBarrier>(animatedModalBarrier).color;
      expect(
        modalBarrierAnimation.value!.alpha,
        closeTo(OTestAnimations.getExpectedBarrierTweenAlphaValue(0.25), 1.0),
      );
    });

    testWidgets('Modal barrier becomes less transparent - 50%', (tester) async {
      _setScreenSize(tester);
      await tester.pumpWidget(testWidget);

      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      final animatedModalBarrier = find.byType(AnimatedModalBarrier);

      final modalBarrierAnimation =
          tester.widget<AnimatedModalBarrier>(animatedModalBarrier).color;
      expect(
        modalBarrierAnimation.value!.alpha,
        closeTo(OTestAnimations.getExpectedBarrierTweenAlphaValue(0.5), 1.0),
      );
    });

    testWidgets('Modal barrier becomes less transparent - 75%', (tester) async {
      _setScreenSize(tester);
      await tester.pumpWidget(testWidget);

      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 150));
      final animatedModalBarrier = find.byType(AnimatedModalBarrier);

      final modalBarrierAnimation =
          tester.widget<AnimatedModalBarrier>(animatedModalBarrier).color;
      expect(
        modalBarrierAnimation.value!.alpha,
        closeTo(OTestAnimations.getExpectedBarrierTweenAlphaValue(0.75), 1.0),
      );
    });

    testWidgets('Modal barrier totally opened', (tester) async {
      _setScreenSize(tester);
      await tester.pumpWidget(testWidget);

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final animatedModalBarrier = find.byType(AnimatedModalBarrier);

      final modalBarrierAnimation =
          tester.widget<AnimatedModalBarrier>(animatedModalBarrier).color;
      expect(modalBarrierAnimation.value, Colors.blue);

      expect(
        modalBarrierAnimation.value!.alpha,
        closeTo(OTestAnimations.getExpectedBarrierTweenAlphaValue(1.0), 1.0),
      );
    });

    testWidgets('Closing animation points to expected place', (tester) async {
      _setScreenSize(tester);
      final _converter = const CoordinatesToAlignment(
        screenSize: Size(100.0, 100.0),
        point: Offset(12.12, 13.13),
      );
      final closingAlignment = _converter.convert();

      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(12.12, 13.13));
      await tester.pump(const Duration(milliseconds: 1));

      final transition = find.byType(ScaleTransition);
      var modalBarrierAlignment =
          tester.widget<ScaleTransition>(transition).alignment;

      expect(modalBarrierAlignment.x, equals(closingAlignment.x));
      expect(modalBarrierAlignment.y, equals(closingAlignment.y));
    });

    testWidgets('Non-dismissible', (tester) async {
      _setScreenSize(tester);
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Builder(
              builder: (context) {
                return Center(
                  child: ElevatedButton(
                    child: const Text('Open'),
                    onPressed: () {
                      Navigator.of(context).push<void>(
                        OPopupOverlay(
                          dismissible: false,
                          content: Container(
                            width: 10.0,
                            height: 10.0,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(12.12, 13.13));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      final animatedModalBarrier = find.byType(AnimatedModalBarrier);

      expect(animatedModalBarrier, findsOneWidget);
    });

    testWidgets('Dismiss with physical back button', (tester) async {
      _setScreenSize(tester);
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();

      expect(find.byType(AnimatedModalBarrier), findsNothing);
    });
  });
}

void _setScreenSize(WidgetTester tester) {
  tester.binding.window.physicalSizeTestValue = const Size(100.0, 100.0);
  tester.binding.window.devicePixelRatioTestValue = 1.0;
  addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
}
