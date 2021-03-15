import 'package:flutter/material.dart';

/// Converts the global position at which the pointer contacted the screen into
/// [Alignment]. Call the convert() method is required to finish converting.
///
/// It uses tap details provided by [GestureDetector]
/// or another [GestureRecognizerFactory].
///
///
/// Typical usage is as follows:
///
/// ```dart
///   GestureDetector(
///    child: Container(
///      width: 50.0,
///      height: 50.0,
///      color: Colors.blue,
///    ),
///    onTapUp: (TapUpDetails tapDetails) {
///      final _converter = CoordinatesToAlignment(
///        point: tapDetails.globalPosition,
///        screenSize: MediaQuery.of(context).size,
///      );
///      final _alignment = _converter.convert();
///
///      print('Coordinates have been converted into Alignment');
///      print('Alignment.x = ' + _alignment.x?.toString());
///      print('Alignment.y = ' + _alignment.y?.toString());
///    },
///  );
/// ```

class CoordinatesToAlignment {
  /// The global position at which the pointer contacted the screen.
  final Offset point;

  /// The screen size.
  final Size screenSize;

  /// Creates a [CoordinatesToAlignment]
  const CoordinatesToAlignment({
    required this.point,
    required this.screenSize,
  });

  double get _alignmentX => point.dx / (screenSize.width / 2) - 1;
  double get _alignmentY => point.dy / (screenSize.height / 2) - 1;

  /// Converts the global position at which the pointer contacted the screen
  /// into [Alignment].
  Alignment convert() => Alignment(_alignmentX, _alignmentY);
}
