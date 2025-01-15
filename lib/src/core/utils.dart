import 'dart:ui';

import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class Utils {
  ///
  /// This method get Offset base on [sliderOpen] type
  ///
  Utils._();

  static Offset getOffsetValueForShadow(
      SlideDirection direction, double value, double slideOpenWidth) {
    switch (direction) {
      case SlideDirection.leftToRight:
        return Offset(value - (slideOpenWidth > 50 ? 20 : 10), 0);
      case SlideDirection.rightToLeft:
        return Offset(-value - 5, 0);
      case SlideDirection.topToBottom:
        return Offset(0, value - (slideOpenWidth > 50 ? 15 : 5));
      default:
        return Offset(value - 30.0, 0);
    }
  }
}
