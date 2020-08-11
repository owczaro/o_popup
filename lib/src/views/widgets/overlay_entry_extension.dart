import 'package:flutter/material.dart';

/// An extension, which gives an ability to copy [OverlayEntry] and change only
/// specific instance fields.

extension copyingOverlayEntry on OverlayEntry {
  OverlayEntry copyWith({
    WidgetBuilder builder,
    bool opaque,
    bool maintainState,
  }) {
    return OverlayEntry(
      builder: builder ?? this.builder,
      opaque: opaque ?? this.opaque,
      maintainState: maintainState ?? this.maintainState,
    );
  }
}