import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../models/convert_coordinates_to_alignment.dart';
import 'modal_barrier_gesture_detector.dart';
import 'overlay_entry_extension.dart';

/// A modal route that overlays a widget over the current route.
/// It adds an ability to save tap details in order to close popup
/// into tapped place.
///
/// You can also use [OPopupTrigger] in order to handle everything.
class OPopupOverlay<T> extends PopupRoute<T> {
  ///  Everything you want to show inside a popup. You can use [OPopupContent].
  final Widget content;

  /// Fill the barrier with this color.
  final Color color;

  /// The duration the transition going forwards and in reverse.
  final Duration barrierAnimationDuration;

  /// Whether you can dismiss this route by tapping the modal barrier.
  final bool dismissible;

  /// The global position at which the pointer contacted the screen.
  /// If null, transition animation has Alignment(0, 0),
  /// so that transition going forwards/ in reverse
  /// goes from/into the center of a screen.
  TapUpDetails tapDetails;

  /// Creates an instance of [OPopupOverlay]
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
  ) =>
      GestureDetector(
        excludeFromSemantics: true,
        child: Material(
          type: MaterialType.transparency,
          child: content,
        ),
        onTapUp: (details) => dismissible ? tapDetails = details : null,
        onTap: () => dismissible ? Navigator.of(context).pop() : null,
      );

  /// Creates transition which going forwards from tapped coordinates.
  /// A similar situation is with transition in reverse.
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    var _alignment = Alignment(0, 0);
    if (tapDetails != null) {
      final _converter = CoordinatesToAlignment(
        point: tapDetails.globalPosition,
        screenSize: MediaQuery.of(context).size,
      );
      _alignment = _converter.convert();
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

  /// Updates tapDetails when user taps the barrier.
  @override
  Iterable<OverlayEntry> createOverlayEntries() sync* {
    var entries = super.createOverlayEntries();
    for (var entry in entries) {
      if (entry is OverlayEntry) {
        var widgetBuilder = Builder(builder: (context) {
          return OModalBarrierGestureDetector(
            child: entry.builder(context),
            onTapUp: (details) {
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
