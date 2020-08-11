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
///    onTapUp: (TapUpDetails details) {
///      var _alignment = CoordinatesToAlignment(
///        point: Offset(
///          details.globalPosition.dx,
///          details.globalPosition.dy,
///        ),
///        screenSize: Size(
///          MediaQuery.of(context).size.width,
///          MediaQuery.of(context).size.height,
///        ),
///      ).convert();
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
  CoordinatesToAlignment({
    @required this.point,
    @required this.screenSize,
  })  : assert(screenSize != null && screenSize.width > 0),
        assert(screenSize != null && screenSize.height > 0),
        assert(point != null &&
            point.dx != null &&
            point.dx.abs() <= (screenSize.width / 2)),
        assert(point != null &&
            point.dy != null &&
            point.dy.abs() <= (screenSize.height / 2));

  double get _alignmentX => point.dx / (screenSize.width / 2) - 1;
  double get _alignmentY => point.dy / (screenSize.height / 2) - 1;

  /// Converts the global position at which the pointer contacted the screen
  /// into [Alignment].
  Alignment convert() => Alignment(_alignmentX, _alignmentY);
}
