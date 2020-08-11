import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A smaller version of [GestureDetector]. It detects only tapUp event.

class OModalBarrierGestureDetector extends StatelessWidget {
  final Widget child;
  final GestureTapUpCallback onTapUp;

  const OModalBarrierGestureDetector({
    Key key,
    @required this.child,
    @required this.onTapUp,
  })  : assert(child != null),
        assert(onTapUp != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<Type, GestureRecognizerFactory> gestures =
        <Type, GestureRecognizerFactory>{
      TapGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
        () => TapGestureRecognizer(debugOwner: this),
        (TapGestureRecognizer instance) => instance..onTapUp = onTapUp,
      ),
    };

    return RawGestureDetector(
      gestures: gestures,
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
