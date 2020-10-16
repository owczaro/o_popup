import 'package:flutter/material.dart';

/// A grid of popup content. It keeps each part of popup in a proper place:
/// * header, content and action row are centered
/// * each part is limited proportionally
///   * width: max device width minus 20px
///   * height:
///     - header: 1/3 of max device height minus 100px
///     - content: 2/3 of max device height minus 100px
///     - actionRow: all space left
/// * content is scrollable vertically
///
/// At least one of the fields must be set: header, content or actionRow.
class OPopupContent extends StatelessWidget {
  /// Popup header.
  final Widget header;

  /// Popup content.
  final Widget content;

  /// Popup actionRow.
  final Widget actionRow;

  /// Creates an instance of [OPopupContent]
  const OPopupContent({
    this.header,
    this.content,
    this.actionRow,
    Key key,
  })  : assert(header != null || content != null || actionRow != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (header != null) ...{
            headerBuilder(context),
          },
          if (content != null) ...{
            contentBuilder(context),
          },
          if (actionRow != null) ...{
            actionRowBuilder(context),
          },
        ],
      );

  /// Creates unified (color: [Colors.white], fontWeight: [FontWeight.bold])
  /// headers inside [OPopupContent.standardizedText].
  static Widget standardizedHeader(String headerText) => standardizedText(
        headerText,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );

  /// Creates unified (color: [Colors.white], textAlign: [TextAlign.center])
  /// text inside [Scrollbar].
  static Widget standardizedText(
    String text, {
    TextStyle style,
  }) =>
      Scrollbar(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: style ?? TextStyle(color: Colors.white),
        ),
      );

  /// Builds header inside [LimitedBox]. You can overwrite this method
  /// if you want to customize header.
  Widget headerBuilder(BuildContext context) => Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: LimitedBox(
                maxHeight: MediaQuery.of(context).size.height / 3 - 100.0,
                maxWidth: MediaQuery.of(context).size.width - 20.0,
                child: header,
              ),
            ),
          ],
        ),
      );

  /// Builds content inside [LimitedBox]. You can overwrite this method
  /// if you want to customize content.
  Widget contentBuilder(BuildContext context) => Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: LimitedBox(
                maxHeight: MediaQuery.of(context).size.height / 3 * 2 - 100.0,
                maxWidth: MediaQuery.of(context).size.width - 20.0,
                child: Scrollbar(child: content),
              ),
            ),
          ],
        ),
      );

  /// Builds action row. You can overwrite this method
  /// if you want to customize action row.
  Widget actionRowBuilder(BuildContext context) => Padding(
        padding: EdgeInsets.all(10.0),
        child: actionRow,
      );
}
