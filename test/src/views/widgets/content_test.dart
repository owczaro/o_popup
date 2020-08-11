import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:o_popup/o_popup.dart';

/// Tests [OPopupContent]

void main() {
  group(
    '[Views/Widgets] OPopupContent',
    () {
      testWidgets('Has all fields', (WidgetTester tester) async {
        final testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
            home: OPopupContent(
              header: Text('Test header'),
              content: Text('Some content'),
              actionRow: Row(
                children: [
                  OutlineButton(
                    textColor: Colors.white,
                    child: Text('Action Button'),
                    onPressed: () => null,
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpWidget(testWidget);

        expect(find.text('Test header'), findsOneWidget);
        expect(find.text('Some content'), findsOneWidget);
        expect(find.text('Action Button'), findsOneWidget);
      });

      testWidgets('Has only header', (WidgetTester tester) async {
        final testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
            home: OPopupContent(
              header: Text('Test header'),
            ),
          ),
        );

        await tester.pumpWidget(testWidget);

        expect(find.text('Test header'), findsOneWidget);
      });

      testWidgets('Has only content', (WidgetTester tester) async {
        final testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
            home: OPopupContent(
              content: Text('Some content'),
            ),
          ),
        );

        await tester.pumpWidget(testWidget);

        expect(find.text('Some content'), findsOneWidget);
      });

      testWidgets('Has only action row', (WidgetTester tester) async {
        final testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
            home: OPopupContent(
              actionRow: Row(
                children: [
                  OutlineButton(
                    textColor: Colors.white,
                    child: Text('Action Button'),
                    onPressed: () => null,
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpWidget(testWidget);

        expect(find.text('Action Button'), findsOneWidget);
      });

      testWidgets('Throws an assertion error with no arguments',
          (WidgetTester tester) async {
        final widgetKey = UniqueKey();
        try {
          MediaQuery(
            data: MediaQueryData(),
            child: MaterialApp(
              home: OPopupContent(key: widgetKey),
            ),
          );
          expect(false, isTrue);
        } catch (e) {
          expect(e, isAssertionError);
        }
      });
    },
  );
}
