import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:o_popup/src/models/convert_coordinates_to_alignment.dart';

import '../../helpers/math.dart';

/// Tests [CoordinatesToAlignment]

void main() {
  group('[Models] CoordinatesToAlignment', () {
    final screenSize = const Size(400.0, 600.0);
    test(
        'Device size (W x H): 400 x 600 '
        'and pointer position [(x; y)]: (2.0; -14.0)', () {
      final alignment = CoordinatesToAlignment(
        screenSize: screenSize,
        point: const Offset(2.0, -14.0),
      ).convert();
      expect(alignment.x, equals(-0.99));
      expect(OTestMath.round(alignment.y), equals(-1.047));
    });

    test(
        'Device size (W x H): 400 x 600 '
        'and pointer position [(x; y)]: (200.0; 200.0)', () {
      final alignment = CoordinatesToAlignment(
        screenSize: screenSize,
        point: const Offset(200.0, 200.0),
      ).convert();
      expect(alignment.x, equals(0.0));
      expect(OTestMath.round(alignment.y), equals(-0.333));
    });

    test(
        'Device size (W x H): 400 x 600 '
        'and pointer position [(x; y)]: (0.0; 0.0)', () {
      final alignment = CoordinatesToAlignment(
        screenSize: screenSize,
        point: const Offset(0.0, 0.0),
      ).convert();
      expect(alignment.x, equals(-1.0));
      expect(alignment.y, equals(-1.0));
    });

    test('NULL x', () {
      expect(
          () => CoordinatesToAlignment(
                screenSize: screenSize,
                point: Offset(null, 0.0),
              ).convert(),
          throwsA(isInstanceOf<AssertionError>()));
    });

    test('NULL y', () {
      expect(
          () => CoordinatesToAlignment(
                screenSize: screenSize,
                point: Offset(0.0, null),
              ).convert(),
          throwsA(isInstanceOf<AssertionError>()));
    });

    test('NULL width', () {
      expect(
          () => CoordinatesToAlignment(
                screenSize: Size(null, 600.0),
                point: const Offset(0.0, 0.0),
              ).convert(),
          throwsA(isInstanceOf<AssertionError>()));
    });

    test('NULL height', () {
      expect(
          () => CoordinatesToAlignment(
                screenSize: Size(400.0, null),
                point: const Offset(0.0, 0.0),
              ).convert(),
          throwsA(isInstanceOf<AssertionError>()));
    });

    test('0 width', () {
      expect(
          () => CoordinatesToAlignment(
                screenSize: const Size(0.0, 600.0),
                point: const Offset(0.0, 0.0),
              ).convert(),
          throwsA(isInstanceOf<AssertionError>()));
    });

    test('0 height', () {
      expect(
          () => CoordinatesToAlignment(
                screenSize: const Size(400.0, 0.0),
                point: const Offset(0.0, 0.0),
              ).convert(),
          throwsA(isInstanceOf<AssertionError>()));
    });

    test('x greater than width/2', () {
      expect(
          () => CoordinatesToAlignment(
                screenSize: screenSize,
                point: const Offset(201.0, 200.0),
              ).convert(),
          throwsA(isInstanceOf<AssertionError>()));
    });

    test('y greater than height/2', () {
      expect(
          () => CoordinatesToAlignment(
                screenSize: screenSize,
                point: const Offset(200.0, 301.0),
              ).convert(),
          throwsA(isInstanceOf<AssertionError>()));
    });
  });
}
