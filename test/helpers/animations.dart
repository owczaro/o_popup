import 'package:flutter/material.dart';

class OTestAnimations {
  static int getExpectedBarrierTweenAlphaValue(double t) {
    final CurveTween _customBarrierTween = CurveTween(curve: Curves.ease);
    return Color.getAlphaFromOpacity(_customBarrierTween.transform(t));
  }
}
