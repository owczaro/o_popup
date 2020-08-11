import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:o_popup/src/models/convert_coordinates_to_alignment.dart';
import 'package:o_popup/src/views/widgets/modal_barrier_gesture_detector.dart';
import 'package:o_popup/src/views/widgets/overlay_entry_extension.dart';

/// This class represents a popup barrier.
/// It adds an ability to save tap details in order to close popup
/// into tapped place.
///
/// Content parameter is everything you want to show inside popup.
/// You can use OPopupContent class here.
///
/// Color is a barrier color. By default it is Colors.black.withOpacity(0.7)
///
/// BarrierAnimationDuration is a duration of open/close animation.
///
/// Dismissible - if sets to true, you can dismiss a popup by tapping a barrier.
///
/// TapDetails - you can pass details of tapped place which triggered to
/// open a popup. You can provide that with [GestureDetector].
/// If you don't provide that parameter, popup closes into the center of a screen.
/// You can also use [OPopupTrigger] in order to handle everything.

class OPopupOverlay extends PopupRoute {
  final Widget content;
  final Color color;
  final Duration barrierAnimationDuration;
  final bool dismissible;
  TapUpDetails tapDetails;

  OPopupOverlay({
    this.dismissible = true,
    this.color,
    this.barrierAnimationDuration,
    @required this.content,
    this.tapDetails,
    RouteSettings setting,
  })  : assert(content != null),
        super(settings: setting);

  @override
  bool get barrierDismissible => dismissible;

  @override
  Color get barrierColor => color ?? Colors.black.withOpacity(0.7);

  @override
  Duration get transitionDuration =>
      barrierAnimationDuration ?? const Duration(milliseconds: 200);

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return GestureDetector(
      excludeFromSemantics: true,
      child: Material(
        type: MaterialType.transparency,
        child: content,
      ),
      onTapUp: (TapUpDetails details) =>
          dismissible ? tapDetails = details : null,
      onTap: () => Navigator.of(context).pop(),
    );
  }

  /// Creates opening animation which starts at tapped coordinates.
  /// Closing animation closes into tapped coordinates.
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    var _alignment = Alignment(0, 0);
    if (tapDetails != null) {
      _alignment = CoordinatesToAlignment(
        point: Offset(
          tapDetails.globalPosition.dx,
          tapDetails.globalPosition.dy,
        ),
        screenSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
      ).convert();
    }
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
        alignment: _alignment,
      ),
    );
  }

  /// Updates tapDetails when user taps an barrier.
  @override
  Iterable<OverlayEntry> createOverlayEntries() sync* {
    var entries = super.createOverlayEntries();
    for (var entry in entries) {
      if (entry is OverlayEntry) {
        var widgetBuilder = Builder(builder: (context) {
          return OModalBarrierGestureDetector(
            child: entry.builder(context),
            onTapUp: (TapUpDetails details) {
              if (dismissible) {
                tapDetails = details;
                Navigator.of(context).pop();
              }
            },
          );
        });
        yield entry.copyWith(builder: widgetBuilder.builder);
      } else {
        yield entry;
      }
    }
  }
}
