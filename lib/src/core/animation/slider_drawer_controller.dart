import 'package:flutter/widgets.dart';
import 'package:flutter_slider_drawer/src/slider_direction.dart';

class SliderDrawerController extends ChangeNotifier {
  final AnimationController animationController;
  final SlideDirection slideDirection;
  final double threshold;

  bool _isDragging = false;
  double _percent = 0.0;

  SliderDrawerController({
    required TickerProvider vsync,
    required int animationDuration,
    required this.slideDirection,
    this.threshold = 0.3,
  }) : animationController = AnimationController(
            vsync: vsync, duration: Duration(milliseconds: animationDuration));

  bool get isDragging => _isDragging;

  bool get isDrawerOpen => animationController.isCompleted;

  bool get isHorizontalSlide =>
      slideDirection == SlideDirection.leftToRight ||
      slideDirection == SlideDirection.rightToLeft;

  void toggle() => isDrawerOpen ? closeSlider() : openSlider();

  void openSlider() => animationController.forward();

  void closeSlider() => animationController.reverse();

  void startDragging() {
    _isDragging = true;
    notifyListeners();
  }

  void stopDragging() {
    _isDragging = false;
    _percent > threshold ? openSlider() : closeSlider();
    notifyListeners();
  }

  void updatePosition(double percent) {
    _percent = percent;
    animationController.value = percent;
    notifyListeners();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
