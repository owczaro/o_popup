import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:o_popup/src/views/widgets/overlay_entry_extension.dart';

/// Tests [copyingOverlayEntry]

void main() {
  final originalOverlay = OverlayEntry(
    maintainState: true,
    opaque: true,
    builder: (BuildContext context) => Text('Test 1'),
  );

  group('[Views/Widgets] copyingOverlayEntry.copyWith: maintainState', () {
    final copyWithMaintainState =
        originalOverlay.copyWith(maintainState: false);
    testWidgets('builder', (WidgetTester tester) async {
      expect(copyWithMaintainState.builder, equals(originalOverlay.builder));
    });
    testWidgets('opaque', (WidgetTester tester) async {
      expect(copyWithMaintainState.opaque, equals(originalOverlay.opaque));
    });
    testWidgets('maintainState', (WidgetTester tester) async {
      expect(
        copyWithMaintainState.maintainState,
        isNot(equals(originalOverlay.maintainState)),
      );
    });
  });

  group('[Views/Widgets] copyingOverlayEntry.copyWith: opaque', () {
    final copyWithOpaque = originalOverlay.copyWith(opaque: false);

    testWidgets('builder', (WidgetTester tester) async {
      expect(copyWithOpaque.builder, equals(originalOverlay.builder));
    });
    testWidgets('opaque', (WidgetTester tester) async {
      expect(copyWithOpaque.opaque, isNot(equals(originalOverlay.opaque)));
    });
    testWidgets('maintainState', (WidgetTester tester) async {
      expect(
        copyWithOpaque.maintainState,
        equals(originalOverlay.maintainState),
      );
    });
  });
}
