import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/src/slider_direction.dart';

///
/// Build and Align the Menu widget based on the slide open type
///
class SliderBar extends StatelessWidget {
  final SlideDirection slideDirection;
  final double sliderMenuOpenSize;
  final Widget sliderMenu;

  const SliderBar(
      {Key? key,
      required this.slideDirection,
      required this.sliderMenuOpenSize,
      required this.sliderMenu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var container = SizedBox(width: sliderMenuOpenSize, child: sliderMenu);
    switch (slideDirection) {
      case SlideDirection.leftToRight:
        return container;
      case SlideDirection.rightToLeft:
        return Positioned(right: 0, top: 0, bottom: 0, child: container);
      case SlideDirection.topToBottom:
        return Positioned(right: 0, left: 0, top: 0, child: container);
    }
  }
}
