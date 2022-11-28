import 'package:flutter/widgets.dart';

class SliderShadow {
  final Color shadowColor;

  ///[double] you can change blurRadius of shadow by this parameter [shadowBlurRadius]
  ///
  final double shadowBlurRadius;

  ///[double] you can change spreadRadius of shadow by this parameter [shadowSpreadRadius]
  ///
  final double shadowSpreadRadius;

  SliderShadow(
      {this.shadowColor = const Color(0xFF9E9E9E),
      this.shadowBlurRadius = 25.0,
      this.shadowSpreadRadius = 5.0});
}
