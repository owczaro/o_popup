<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-yellow.svg" alt="License: MIT"></a>
<a href="https://github.com/tenhobi/effective_dart"><img src="https://img.shields.io/badge/style-effective_dart-blue.svg" alt="style: effective dart"></a>
<a href="https://travis-ci.org/github/owczaro/o_popup"><img src="https://travis-ci.org/owczaro/o_popup.svg?branch=master" alt="Travis CI"></a>

---


# OPopup

An overlaid content, which closes itself into opening place (on back button) or into the position where the pointer contacted the screen. It means, popup supports gestures.

<img src="https://raw.githubusercontent.com/owczaro/o_popup/master/example/o_popup_demo.gif" height="500">


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


## Commercial Use

If you use this code in commercial project, please donate me via GitHub Sponsors. I do the same for packages which I use, because it ensures stable development for all of us!
