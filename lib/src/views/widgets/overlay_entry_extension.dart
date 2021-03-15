import 'package:flutter/material.dart';

/// An extension, which gives an ability to copy [OverlayEntry] and change only
/// specific instance fields.
extension CopyingOverlayEntry on OverlayEntry {
  /// Create a clone of the current [OverlayEntry] but with provided
  /// parameters overridden.
  OverlayEntry copyWith({
    WidgetBuilder? builder,
    bool? opaque,
    bool? maintainState,
  }) =>
      OverlayEntry(
        builder: builder ?? this.builder,
        opaque: opaque ?? this.opaque,
        maintainState: maintainState ?? this.maintainState,
      );
}
