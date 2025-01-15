import 'package:flutter/widgets.dart';
import 'package:flutter_slider_drawer/src/core/animation/animation_strategy.dart';
import 'package:flutter_slider_drawer/src/core/animation/slider_drawer_controller.dart';
import 'package:flutter_slider_drawer/src/core/appbar/slider_app_bar.dart';
import 'package:flutter_slider_drawer/src/core/slider_shadow.dart';
import 'package:flutter_slider_drawer/src/slider_shadow.dart';
import 'package:flutter_slider_drawer/src/slider_bar.dart';
import 'package:flutter_slider_drawer/src/slider_direction.dart';

/// SliderDrawer which have two [child] and [slider] parameter
///
///For Example :
///
///SliderDrawer(
///         key: _sliderDrawerKey,
///         appBar: SliderAppBar(
///           config: SliderAppBarConfig(
///               title: Text(
///             title,
///             textAlign: TextAlign.center,
///             style: const TextStyle(
///               fontSize: 22,
///               fontWeight: FontWeight.w700,
///             ),
///           )),
///         ),
///         sliderOpenSize: 179,
///         slider: SliderMenu(),
///         child: const AuthorList(),
///       )
///
///
///
class SliderDrawer extends StatefulWidget {
  /// [Widget] which display when user open drawer
  ///
  final Widget slider;

  /// [Widget] main screen widget
  ///
  final Widget child;

  /// [int] animation duration for the drawer's open/close action in milliseconds.
  /// parameter
  ///
  final int animationDuration;

  /// The width of the open drawer.
  ///
  final double sliderOpenSize;

  ///[double]  The width of the closed drawer. Default is 0.
  final double sliderCloseSize;

  ///[bool] if you set [false] then swipe to open feature disable.
  ///By Default it's true
  ///
  final bool isDraggable;

  ///[appBar] if you set [null] then it will not display app bar
  ///
  final Widget? appBar;

  ///[SliderBoxShadow] you can enable shadow of [child] Widget by this parameter
  final SliderBoxShadow? sliderBoxShadow;

  ///[slideDirection] you can change slide direction by this parameter [slideDirection]
  ///There are three type of [SlideDirection]
  ///[SlideDirection.rightToLeft]
  ///[SlideDirection.leftToRight]
  ///[SlideDirection.topToBottom]
  ///
  /// By default it's [SlideDirection.leftToRight]
  ///
  final SlideDirection slideDirection;

// The color of the [Material] widget that underlies the entire Scaffold.
  ///
  /// The theme's [ThemeData.scaffoldBackgroundColor] by default.
  final Color? backgroundColor;

  const SliderDrawer(
      {Key? key,
      required this.slider,
      required this.child,
      this.isDraggable = true,
      this.animationDuration = 400,
      this.sliderOpenSize = 265,
      this.sliderCloseSize = 0,
      this.slideDirection = SlideDirection.leftToRight,
      this.sliderBoxShadow,
      this.appBar,
      this.backgroundColor})
      : super(key: key);

  @override
  SliderDrawerState createState() => SliderDrawerState();
}

class SliderDrawerState extends State<SliderDrawer>
    with TickerProviderStateMixin {
  late final SliderDrawerController _controller;
  late final Animation<double> _animation;
  late final AnimationStrategy _animationStrategy;

  /// check whether drawer is open
  bool get isDrawerOpen => _controller.animationController.isCompleted;

  /// it's provide [animationController] for handle and lister drawer animation
  AnimationController get animationController =>
      _controller.animationController;

  /// Toggle drawer
  void toggle() => _controller.toggle();

  /// Open slider
  void openSlider() => _controller.openSlider();

  /// Close slider
  void closeSlider() => _controller.closeSlider();

  @override
  void initState() {
    super.initState();
    _controller = SliderDrawerController(
      vsync: this,
      animationDuration: widget.animationDuration,
      slideDirection: widget.slideDirection,
    );

    _animation = Tween<double>(
      begin: widget.sliderCloseSize,
      end: widget.sliderOpenSize,
    ).animate(CurvedAnimation(
      parent: _controller.animationController,
      curve: Curves.decelerate,
      reverseCurve: Curves.decelerate,
    ));

    _animationStrategy = SliderAnimationStrategy();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            SliderBar(
              slideDirection: widget.slideDirection,
              sliderMenu: widget.slider,
              sliderMenuOpenSize: widget.sliderOpenSize,
            ),

            /// Shadow Shadow
            if (widget.sliderBoxShadow != null)
              SliderShadow(
                animationDrawerController: _controller.animationController,
                slideDirection: widget.slideDirection,
                sliderOpenSize: widget.sliderOpenSize,
                animation: _animation,
                sliderBoxShadow: widget.sliderBoxShadow!,
              ),

            AnimatedBuilder(
              animation: _controller.animationController,
              builder: (context, child) => Transform.translate(
                offset: _animationStrategy.getOffset(
                  widget.slideDirection,
                  _animation.value,
                ),
                child: child,
              ),
              child: GestureDetector(
                onHorizontalDragStart: widget.isDraggable
                    ? (details) => _handleDragStart(details)
                    : null,
                onHorizontalDragEnd: widget.isDraggable
                    ? (details) => _handleDragEnd(details)
                    : null,
                onHorizontalDragUpdate: widget.isDraggable
                    ? (details) => _handleDragUpdate(details, constraints)
                    : null,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: widget.backgroundColor ?? Color(0xFFFFFFFF),
                  child: Column(
                    children: [
                      AppBar(
                        animationDrawerController:
                            _controller.animationController,
                        appBar: widget.appBar,
                        onDrawerTap: _controller.toggle,
                      ),
                      Expanded(child: widget.child),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void _handleDragStart(DragStartDetails details) {
    if (_animationStrategy.shouldStartDrag(
        details, context, widget.slideDirection)) {
      _controller.startDragging();
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    _controller.stopDragging();
  }

  void _handleDragUpdate(
      DragUpdateDetails details, BoxConstraints constraints) {
    _animationStrategy.handleDragUpdate(details, constraints, _controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
