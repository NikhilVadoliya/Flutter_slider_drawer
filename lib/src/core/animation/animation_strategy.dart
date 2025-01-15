import 'package:flutter/widgets.dart';
import 'package:flutter_slider_drawer/src/core/animation/slider_drawer_controller.dart';
import 'package:flutter_slider_drawer/src/slider_direction.dart';

abstract class AnimationStrategy {
  Offset getOffset(SlideDirection direction, double value);

  bool shouldStartDrag(
      DragStartDetails details, BuildContext context, SlideDirection direction);

  void handleDragUpdate(DragUpdateDetails details, BoxConstraints constraints,
      SliderDrawerController controller);
}

class SliderAnimationStrategy implements AnimationStrategy {
  static const double _kWidthGesture = 50.0;
  static const double _kHeightGesture = 30.0;

  @override
  Offset getOffset(SlideDirection direction, double value) {
    switch (direction) {
      case SlideDirection.leftToRight:
        return Offset(value, 0);
      case SlideDirection.rightToLeft:
        return Offset(-value, 0);
      case SlideDirection.topToBottom:
        return Offset(0, value);
    }
  }

  @override
  void handleDragUpdate(DragUpdateDetails details, BoxConstraints constraints,
      SliderDrawerController controller) {
    if (controller.isHorizontalSlide) {
      var position =
          (details.globalPosition.dx).clamp(0.0, constraints.maxWidth) /
              constraints.maxWidth;

      if (controller.slideDirection == SlideDirection.rightToLeft) {
        position = 1 - position;
      }

      controller.updatePosition(position);
    }
  }

  @override
  bool shouldStartDrag(DragStartDetails details, BuildContext context,
      SlideDirection direction) {
    final rightSideWidthGesture =
        MediaQuery.sizeOf(context).width - _kWidthGesture;

    switch (direction) {
      case SlideDirection.leftToRight:
        return details.localPosition.dx <= _kWidthGesture;
      case SlideDirection.rightToLeft:
        return details.localPosition.dx >= rightSideWidthGesture;
      case SlideDirection.topToBottom:
        return details.localPosition.dy >= _kHeightGesture;
    }
  }
}
