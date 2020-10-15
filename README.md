<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-yellow.svg" alt="License: MIT"></a>
<a href="https://github.com/tenhobi/effective_dart"><img src="https://img.shields.io/badge/style-effective_dart-blue.svg" alt="style: effective dart"></a>
<a href="https://travis-ci.org/github/owczaro/o_popup"><img src="https://travis-ci.org/owczaro/o_popup.svg?branch=master" alt="Travis CI"></a>

---


## Description

An overlaid content, which closes itself into opening place (on back button) or into the position where the pointer contacted the screen. It means, popup supports tap gesture!

<img src="https://raw.githubusercontent.com/owczaro/o_popup/master/example/o_popup_demo.gif" height="500">


## Implementation

First of all, you need to [install](https://pub.dev/packages/o_popup/install) the package.
The second step is to create a popup. I recommend to use [OPopupTrigger class](https://pub.dev/documentation/o_popup/latest/o_popup/OPopupTrigger-class.html) in order to simply create the popup as in [the example](https://pub.dev/packages/o_popup/example). It pushes [OPopupOverlay widget](https://pub.dev/documentation/o_popup/latest/o_popup/OPopupOverlay-class.html) into `Navigation` stack, thus a user can dismiss the popup by back button or by tapping anywhere on a screen. In the `OPopupTrigger` class you can also set `barrierDismissible` to `false` (to prevent dismissing popup by taping anywhere) and for example create a button, which pops `Navigator` (`Navigator.of(context).pop()`) in order to close the popup - like buttons in [the example](https://github.com/owczaro/o_popup/blob/master/example/lib/demo.dart).


## Documentation

Extended documentation is available [on pub.dev](https://pub.dev/documentation/o_popup/latest/o_popup/o_popup-library.html).


## Commercial Use

If you use this code in commercial project, please donate me via GitHub Sponsors. I do the same for packages which I use, because it ensures stable development for all of us!
