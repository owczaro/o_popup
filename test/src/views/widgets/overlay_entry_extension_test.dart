import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:o_popup/src/views/widgets/overlay_entry_extension.dart';

/// Tests [copyingOverlayEntry]

void main() {
  final originalOverlay = OverlayEntry(
    maintainState: true,
    opaque: true,
    builder: (context) => Text('Test 1'),
  );

  group('[Views/Widgets] copyingOverlayEntry.copyWith: builder', () {
    final copyWithBuilder =
        originalOverlay.copyWith(builder: (context) => Text('Test builder 1'));
    testWidgets('builder', (tester) async {
      expect(copyWithBuilder.builder, isNot(equals(originalOverlay.builder)));
    });
    testWidgets('opaque', (tester) async {
      expect(copyWithBuilder.opaque, equals(originalOverlay.opaque));
    });
    testWidgets('maintainState', (tester) async {
      expect(
        copyWithBuilder.maintainState,
        equals(originalOverlay.maintainState),
      );
    });
  });

  group('[Views/Widgets] copyingOverlayEntry.copyWith: opaque', () {
    final copyWithOpaque = originalOverlay.copyWith(opaque: false);

    testWidgets('builder', (tester) async {
      expect(copyWithOpaque.builder, equals(originalOverlay.builder));
    });
    testWidgets('opaque', (tester) async {
      expect(copyWithOpaque.opaque, isNot(equals(originalOverlay.opaque)));
    });
    testWidgets('maintainState', (tester) async {
      expect(
        copyWithOpaque.maintainState,
        equals(originalOverlay.maintainState),
      );
    });
  });

  group('[Views/Widgets] copyingOverlayEntry.copyWith: maintainState', () {
    final copyWithMaintainState =
        originalOverlay.copyWith(maintainState: false);
    testWidgets('builder', (tester) async {
      expect(copyWithMaintainState.builder, equals(originalOverlay.builder));
    });
    testWidgets('opaque', (tester) async {
      expect(copyWithMaintainState.opaque, equals(originalOverlay.opaque));
    });
    testWidgets('maintainState', (tester) async {
      expect(
        copyWithMaintainState.maintainState,
        isNot(equals(originalOverlay.maintainState)),
      );
    });
  });
}
