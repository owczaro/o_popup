import 'package:flutter/material.dart';

import '../../../o_popup.dart';
import 'overlay.dart';

/// It simplifies the process of creating a widget which triggers popup.
///
///
/// Typical usage is as follows:
///
/// ```dart
/// OPopupTrigger(
///    barrierDismissible: false, // by default barrier is dismissible, you can change it though
///    barrierColor: Colors.black.withOpacity(0.1), // control over color and opacity of a barrier
///    barrierAnimationDuration: const Duration(milliseconds: 150), // control over barrier animation
///    triggerWidget: Text('Some text'), // or any [Widget]
///    popupHeader: OPopupContent.standardizedHeader('Header text here'), // or any [Widget]
///    popupContent: OPopupContent.standardizedText( // or any [Widget]
///      'Some content',
///    ),
///    popupActionRow: Row( // or any [Widget]
///      mainAxisAlignment: MainAxisAlignment.spaceAround,
///      children: [
///        OutlineButton(
///          textColor: Colors.white,
///          child: Text('Yes'),
///          onPressed: () => Navigator.of(context).pop(),
///        ),
///        OutlineButton(
///          textColor: Colors.white,
///          child: Text('No'),
///          onPressed: () => Navigator.of(context).pop(),
///        ),
///      ],
///    ),
/// );
/// ```
class OPopupTrigger extends StatefulWidget {
  /// Widget which fires popup.
  final Widget triggerWidget;

  /// Popup header.
  final Widget popupHeader;

  /// Popup content.
  final Widget popupContent;

  /// Popup action row.
  final Widget popupActionRow;

  /// Fill the barrier with this color.
  final Color barrierColor;

  /// Whether you can dismiss popup route by tapping the modal barrier.
  final bool barrierDismissible;

  /// The duration the transition of popup going forwards and in reverse.
  final Duration barrierAnimationDuration;

  /// Creates an instance of [OPopupTrigger]
  const OPopupTrigger({
    Key key,
    @required this.triggerWidget,
    this.popupHeader,
    this.popupContent,
    this.popupActionRow,
    this.barrierColor,
    this.barrierDismissible = true,
    this.barrierAnimationDuration,
  })  : assert(popupHeader != null ||
            popupContent != null ||
            popupActionRow != null),
        super(key: key);

  @override
  _OPopupTriggerState createState() => _OPopupTriggerState();
}

class _OPopupTriggerState extends State<OPopupTrigger> {
  TapUpDetails openingTapDetails;

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: widget.triggerWidget,
        onTapUp: (details) => setState(() {
          openingTapDetails = details;
        }),
        onTap: () => Navigator.of(context).push(_popup(openingTapDetails)),
      );

  OPopupOverlay _popup(TapUpDetails openingTapDetails) => OPopupOverlay(
        dismissible: widget.barrierDismissible,
        barrierAnimationDuration: widget.barrierAnimationDuration,
        tapDetails: openingTapDetails,
        color: widget.barrierColor,
        content: OPopupContent(
          header: widget.popupHeader,
          content: widget.popupContent,
          actionRow: widget.popupActionRow,
        ),
      );
}
