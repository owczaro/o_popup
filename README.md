## Commercial Use

If you use this code in commercial project, please donate me via GitHub Sponsors. I do the same for packages which I use, because it ensures stable development for all of us!


## Description

Overlaid content, which closes itself into opening place (on back button) or into the position where the pointer contacted the screen. You can create simple popup with or without header, content and action row.

<img src="/example/o_popup_demo.gif" height="500">


## Add to your Flutter project

You just need to add `o_popup` as a dependency [in your `pubspec.yaml` file](https://flutter.io/using-packages/):
```yaml
dependencies:
  o_popup: ^0.1.0
```


## Implementation

In file, where you want to use popup, import required file:
```dart
import 'package:o_popup/o_popup.dart';
```

Place `PopupTrigger` wherever you want
```dart
OPopupTrigger(
  barrierDismissible: false, // by default barrier is dismissible, you can change it though
  barrierColor: Colors.black.withOpacity(0.1), // control over color and opacity of a barrier
  barrierAnimationDuration: const Duration(milliseconds: 150), // control over barrier animation
  triggerWidget: Text('Some text'), // or any [Widget]
  popupContent: OPopupContent.standardizedText( // or any [Widget]
    'Some content',
  ),
)
```
