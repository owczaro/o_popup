import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:o_popup/o_popup.dart';
import 'package:o_popup/src/models/convert_coordinates_to_alignment.dart';

import '../../../helpers/animations.dart';
import '../../../helpers/gestures.dart';

/// Tests [OPopupOverlay]

void main() {
  group('[Views/Widgets] OPopupOverlay', () {
    testWidgets('custom barrierCurve', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(100.0, 100.0);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      final containerKey = UniqueKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Builder(
              builder: (context) {
                return Center(
                  child: RaisedButton(
                    child: const Text('X'),
                    onPressed: () {
                      Navigator.of(context).push<void>(
                        OPopupOverlay(
                          dismissible: true,
                          color: Colors.blue,
                          barrierAnimationDuration:
                              const Duration(milliseconds: 200),
                          content: Container(
                            key: containerKey,
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
        ),
      );

      await tester.tap(find.text('X'));
      await tester.pump();
      final animatedModalBarrier = find.byType(AnimatedModalBarrier);
      expect(animatedModalBarrier, findsOneWidget);

      Animation<Color> modalBarrierAnimation;
      modalBarrierAnimation =
          tester.widget<AnimatedModalBarrier>(animatedModalBarrier).color;
      expect(modalBarrierAnimation.value, Colors.transparent);

      await tester.pump(const Duration(milliseconds: 50));
      modalBarrierAnimation =
          tester.widget<AnimatedModalBarrier>(animatedModalBarrier).color;
      expect(
        modalBarrierAnimation.value.alpha,
        closeTo(OTestAnimations.getExpectedBarrierTweenAlphaValue(0.25), 1.0),
      );

      await tester.pump(const Duration(milliseconds: 50));
      modalBarrierAnimation =
          tester.widget<AnimatedModalBarrier>(animatedModalBarrier).color;
      expect(
        modalBarrierAnimation.value.alpha,
        closeTo(OTestAnimations.getExpectedBarrierTweenAlphaValue(0.5), 1.0),
      );

      await tester.pump(const Duration(milliseconds: 50));
      modalBarrierAnimation =
          tester.widget<AnimatedModalBarrier>(animatedModalBarrier).color;
      expect(
        modalBarrierAnimation.value.alpha,
        closeTo(OTestAnimations.getExpectedBarrierTweenAlphaValue(0.75), 1.0),
      );

      await tester.pumpAndSettle();
      modalBarrierAnimation =
          tester.widget<AnimatedModalBarrier>(animatedModalBarrier).color;
      expect(modalBarrierAnimation.value, Colors.blue);

      await OTestGestures.doTapUp(tester, const Offset(12.12, 13.13));

      final _converter = const CoordinatesToAlignment(
        screenSize: Size(100.0, 100.0),
        point: Offset(12.12, 13.13),
      );
      final closingAlignment = _converter.convert();

      await tester.pump(const Duration(milliseconds: 1));

      final transition = find.byType(ScaleTransition);
      var modalBarrierAlignment =
          tester.widget<ScaleTransition>(transition).alignment;
      expect(modalBarrierAlignment.x, equals(closingAlignment.x));
      expect(modalBarrierAlignment.y, equals(closingAlignment.y));
    });
  });
}
