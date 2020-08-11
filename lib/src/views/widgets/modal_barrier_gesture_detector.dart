import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A smaller version of [GestureDetector]. It detects only tapUp event.

class OModalBarrierGestureDetector extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// A pointer that will trigger a tap with a primary button has stopped
  /// contacting the screen at a particular location.
  final GestureTapUpCallback onTapUp;

  /// Creates an instance of [OModalBarrierGestureDetector]
  const OModalBarrierGestureDetector({
    Key key,
    @required this.child,
    @required this.onTapUp,
  })  : assert(child != null),
        assert(onTapUp != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final gestures = <Type, GestureRecognizerFactory>{
      TapGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
        () => TapGestureRecognizer(debugOwner: this),
        (instance) => instance..onTapUp = onTapUp,
      ),
    };

    return RawGestureDetector(
      gestures: gestures,
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
