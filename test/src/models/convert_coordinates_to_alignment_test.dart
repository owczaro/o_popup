import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:o_popup/src/models/convert_coordinates_to_alignment.dart';

import '../../helpers/math.dart';

/// Tests [CoordinatesToAlignment]

void main() {
  group('[Models] CoordinatesToAlignment', () {
    test(
        'Device size (W x H): 400 x 600 '
        'and pointer position [(x; y)]: (2.0; -14.0)', () {
      final converter = const CoordinatesToAlignment(
        screenSize: Size(400.0, 600.0),
        point: Offset(2.0, -14.0),
      );
      final alignment = converter.convert();
      expect(alignment.x, equals(-0.99));
      expect(OTestMath.round(alignment.y), equals(-1.047));
    });

    test(
        'Device size (W x H): 400 x 600 '
        'and pointer position [(x; y)]: (200.0; 200.0)', () {
      final converter = const CoordinatesToAlignment(
        screenSize: Size(400.0, 600.0),
        point: Offset(200.0, 200.0),
      );
      final alignment = converter.convert();
      expect(alignment.x, equals(0.0));
      expect(OTestMath.round(alignment.y), equals(-0.333));
    });

    test(
        'Device size (W x H): 400 x 600 '
        'and pointer position [(x; y)]: (0.0; 0.0)', () {
      final converter = const CoordinatesToAlignment(
        screenSize: Size(400.0, 600.0),
        point: Offset(0.0, 0.0),
      );
      final alignment = converter.convert();
      expect(alignment.x, equals(-1.0));
      expect(alignment.y, equals(-1.0));
    });

    test(
        'Device size (W x H): 400 x 600 '
        'and pointer position [(x; y)]: (400.0; 600.0)', () {
      final converter = const CoordinatesToAlignment(
        screenSize: Size(400.0, 600.0),
        point: Offset(400.0, 600.0),
      );
      final alignment = converter.convert();
      expect(alignment.x, equals(1.0));
      expect(alignment.y, equals(1.0));
    });
  });
}
