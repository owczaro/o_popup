import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:o_popup/o_popup.dart';

/// Tests [OPopupContent]

void main() {
  group(
    '[Views/Widgets] OPopupContent',
    () {
      testWidgets('Has all fields', (tester) async {
        final testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
            home: OPopupContent(
              header: Text('Test header'),
              content: Text('Some content'),
              actionRow: Row(
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      textStyle: TextStyle(color: Colors.white),
                    ),
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

      testWidgets('Has only header', (tester) async {
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

      testWidgets('Has only content', (tester) async {
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

      testWidgets('Has only action row', (tester) async {
        final testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
            home: OPopupContent(
              actionRow: Row(
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      textStyle: TextStyle(color: Colors.white),
                    ),
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
          (tester) async {
        try {
          MediaQuery(
            data: MediaQueryData(),
            child: MaterialApp(
              home: OPopupContent(),
            ),
          );
          expect(false, isTrue);
          // ignore: avoid_catches_without_on_clauses
        } catch (e) {
          expect(e, isAssertionError);
        }
      });
    },
  );

  group(
    '[Views/Widgets] OPopupContent.standardizedHeader',
    () {
      testWidgets('Proper styling', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: OPopupContent.standardizedHeader('Test header'),
            ),
          ),
        );

        expect(
          (tester.firstWidget(find.text('Test header')) as Text).style,
          TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      });
    },
  );

  group(
    '[Views/Widgets] OPopupContent.standardizedText',
    () {
      testWidgets('Proper default styling', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: OPopupContent.standardizedText('Test header'),
            ),
          ),
        );

        expect(
          (tester.firstWidget(find.text('Test header')) as Text).style,
          TextStyle(color: Colors.white),
        );
      });

      testWidgets('Contains Scrollbar', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: OPopupContent.standardizedText('Test header'),
            ),
          ),
        );

        expect(find.byType(Scrollbar), findsOneWidget);
      });

      testWidgets('Proper custom styling', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: OPopupContent.standardizedText('Test header',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 66.6,
                  )),
            ),
          ),
        );

        expect(
          (tester.firstWidget(find.text('Test header')) as Text).style,
          TextStyle(
            color: Colors.blue,
            fontSize: 66.6,
          ),
        );
      });
    },
  );

  group(
    '[Views/Widgets] OPopupContent.headerBuilder',
    () {
      testWidgets('LimitedBox(maxHeight: 0.0, maxWidth: 0.0)', (tester) async {
        tester.binding.window.physicalSizeTestValue = const Size(20.0, 300.0);
        tester.binding.window.devicePixelRatioTestValue = 1.0;
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: Builder(builder: (context) {
                return OPopupContent(header: Text('Test Header'))
                    .headerBuilder(context);
              }),
            ),
          ),
        );

        final limitedBox =
            tester.firstWidget(find.byType(LimitedBox)) as LimitedBox;
        expect(limitedBox.maxHeight, 0.0);
        expect(limitedBox.maxWidth, 0.0);
      });
    },
  );

  group(
    '[Views/Widgets] OPopupContent.contentBuilder',
    () {
      testWidgets('LimitedBox(maxHeight: 0.0, maxWidth: 0.0)', (tester) async {
        tester.binding.window.physicalSizeTestValue = const Size(20.0, 150.0);
        tester.binding.window.devicePixelRatioTestValue = 1.0;
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: Builder(builder: (context) {
                return OPopupContent(content: Text('Test Content'))
                    .contentBuilder(context);
              }),
            ),
          ),
        );

        final limitedBox =
            tester.firstWidget(find.byType(LimitedBox)) as LimitedBox;
        expect(limitedBox.maxHeight, 0.0);
        expect(limitedBox.maxWidth, 0.0);
      });
    },
  );

  group(
    '[Views/Widgets] OPopupContent.actionRowBuilder',
    () {
      testWidgets('No LimitedBox', (tester) async {
        tester.binding.window.physicalSizeTestValue = const Size(200.0, 200.0);
        tester.binding.window.devicePixelRatioTestValue = 1.0;
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: Builder(builder: (context) {
                return OPopupContent(actionRow: Text('Test ActionRow'))
                    .actionRowBuilder(context);
              }),
            ),
          ),
        );

        expect(find.byType(LimitedBox), findsNothing);
      });
    },
  );
}
