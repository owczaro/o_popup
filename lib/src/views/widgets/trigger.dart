import 'package:o_popup/o_popup.dart';
import 'package:o_popup/src/views/widgets/overlay.dart';
import 'package:flutter/material.dart';

/// That widget is kinda helper, which simplifies the process of creating
/// a widget which triggers popup.
///
/// TriggerWidget is required.
/// Also one of following: popupHeader, popupContent, popupActionRow.
///
///
/// Example:
///
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
/// )

class OPopupTrigger extends StatefulWidget {
  final Widget triggerWidget;
  final Widget popupHeader;
  final Widget popupContent;
  final Widget popupActionRow;
  final Color barrierColor;
  final bool barrierDismissible;
  final Duration barrierAnimationDuration;

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
        onTapUp: (TapUpDetails details) => widget.barrierDismissible
            ? setState(() {
                openingTapDetails = details;
              })
            : null,
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
