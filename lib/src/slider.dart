import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/src/app_bar.dart';
import 'package:flutter_slider_drawer/src/helper/slider_app_bar.dart';
import 'package:flutter_slider_drawer/src/helper/slider_shadow.dart';
import 'package:flutter_slider_drawer/src/slider_bar.dart';
import 'package:flutter_slider_drawer/src/helper/utils.dart';
import 'package:flutter_slider_drawer/src/slider_direction.dart';

/// SliderDrawer which have two [child] and [slider] parameter
///
///For Example :
///
/// Scaffold(
///         body: SliderDrawer(
///             appBar: SliderAppBar(
///                 appBarColor: Colors.white,
///                 title: Text(title,
///                     style: const TextStyle(
///                         fontSize: 22, fontWeight: FontWeight.w700))),
///             key: _key,
///             sliderOpenSize: 200,
///             slider: SliderView(
///               onItemClick: (title) {
///                 _key.currentState!.closeSlider();
///                 setState(() {
///                   this.title = title;
///                 });
///               },
///             ),
///             child: AuthorList()),
///       )
///
///
class SliderDrawer extends StatefulWidget {
  /// [Widget] which display when user open drawer
  ///
  final Widget slider;

  /// [Widget] main screen widget
  ///
  final Widget child;

  /// [int] you can changes sliderDrawer open/close animation times with this [animationDuration]
  /// parameter
  ///
  final int animationDuration;

  /// [double] you can change open drawer size by this parameter [sliderOpenSize]
  ///
  final double sliderOpenSize;

  ///[double] you can change close drawer size by this parameter [sliderCloseSize]
  /// by Default it is 0. if you set 30 then drawer will not close full it will display 30 size of width always
  ///
  final double sliderCloseSize;

  ///[bool] if you set [false] then swipe to open feature disable.
  ///By Default it's true
  ///
  final bool isDraggable;

  ///[appBar] if you set [null] then it will not display app bar
  ///
  final SliderAppBar? appBar;

  /// The primary color of the button when the drawer button is in the down (pressed) state.
  /// The splash is represented as a circular overlay that appears above the
  /// [highlightColor] overlay. The splash overlay has a center point that matches
  /// the hit point of the user touch event. The splash overlay will expand to
  /// fill the button area if the touch is held for long enough time. If the splash
  /// color has transparency then the highlight and drawer button color will show through.
  ///
  /// Defaults to the Theme's splash color, [ThemeData.splashColor].
  ///
  final Color splashColor;

  ///[SliderShadow] you can enable shadow of [child] Widget by this parameter
  final SliderShadow? sliderShadow;

  ///[slideDirection] you can change slide direction by this parameter [slideDirection]
  ///There are three type of [SlideDirection]
  ///[SlideDirection.RIGHT_TO_LEFT]
  ///[SlideDirection.LEFT_TO_RIGHT]
  ///[SlideDirection.TOP_TO_BOTTOM]
  ///
  /// By default it's [SlideDirection.LEFT_TO_RIGHT]
  ///
  final SlideDirection slideDirection;

  const SliderDrawer({
    Key? key,
    required this.slider,
    required this.child,
    this.isDraggable = true,
    this.animationDuration = 400,
    this.sliderOpenSize = 265,
    this.splashColor = Colors.transparent,
    this.sliderCloseSize = 0,
    this.slideDirection = SlideDirection.LEFT_TO_RIGHT,
    this.sliderShadow,
    this.appBar = const SliderAppBar(),
  }) : super(key: key);

  @override
  SliderDrawerState createState() => SliderDrawerState();
}

class SliderDrawerState extends State<SliderDrawer>
    with TickerProviderStateMixin {
  static const double WIDTH_GESTURE = 50.0;
  static const double HEIGHT_GESTURE = 30.0;
  static const double BLUR_SHADOW = 20.0;
  double _percent = 0.0;

  AnimationController? _animationDrawerController;
  late Animation _animation;

  bool _isDragging = false;

  /// check whether drawer is open
  bool get isDrawerOpen => _animationDrawerController!.isCompleted;

  /// it's provide [animationController] for handle and lister drawer animation
  AnimationController? get animationController => _animationDrawerController;

  /// Toggle drawer
  void toggle() => _animationDrawerController!.isCompleted
      ? _animationDrawerController!.reverse()
      : _animationDrawerController!.forward();

  /// Open slider
  void openSlider() => _animationDrawerController!.forward();

  /// Close slider
  void closeSlider() => _animationDrawerController!.reverse();

  @override
  void initState() {
    super.initState();

    _animationDrawerController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration));

    _animation =
        Tween<double>(begin: widget.sliderCloseSize, end: widget.sliderOpenSize)
            .animate(CurvedAnimation(
                parent: _animationDrawerController!,
                curve: Curves.decelerate,
                reverseCurve: Curves.decelerate));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      return Container(
          child: Stack(children: <Widget>[
        ///  Menu
        SliderBar(
          slideDirection: widget.slideDirection,
          sliderMenu: widget.slider,
          sliderMenuOpenSize: widget.sliderOpenSize,
        ),

        /// Displaying the  shadow
        if (widget.sliderShadow != null) ...[
          _Shadow(
            animationDrawerController: _animationDrawerController,
            slideDirection: widget.slideDirection,
            sliderOpenSize: widget.sliderOpenSize,
            animation: _animation,
            sliderShadow: widget.sliderShadow!,
          ),
        ],

        //Child
        AnimatedBuilder(
          animation: _animationDrawerController!,
          builder: (_, child) {
            return Transform.translate(
              offset: Utils.getOffsetValues(
                  widget.slideDirection, _animation.value),
              child: child,
            );
          },
          child: GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onHorizontalDragStart: _onHorizontalDragStart,
            onHorizontalDragEnd: _onHorizontalDragEnd,
            onHorizontalDragUpdate: (detail) =>
                _onHorizontalDragUpdate(detail, constrain),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: widget.appBar?.appBarColor ?? Colors.transparent,
              child: Column(
                children: <Widget>[
                  if (widget.appBar != null)
                    SAppBar(
                      slideDirection: widget.slideDirection,
                      onTap: () => toggle(),
                      animationController: _animationDrawerController!,
                      drawerIcon: widget.appBar!.drawerIcon,
                      drawerIconColor: widget.appBar!.drawerIconColor,
                      drawerIconSize: widget.appBar!.drawerIconSize,
                      splashColor: widget.splashColor,
                      sliderAppBar: widget.appBar!,
                    ),
                  Expanded(child: widget.child),
                ],
              ),
            ),
          ),
        ),
      ]));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationDrawerController!.dispose();
  }

  void _onHorizontalDragStart(DragStartDetails detail) {
    if (!widget.isDraggable) return;

    //Check use start dragging from left edge / right edge then enable dragging
    if ((widget.slideDirection == SlideDirection.LEFT_TO_RIGHT &&
                detail.localPosition.dx <= WIDTH_GESTURE) ||
            (widget.slideDirection == SlideDirection.RIGHT_TO_LEFT &&
                detail.localPosition.dx >=
                    WIDTH_GESTURE) /*&&
        detail.localPosition.dy <= widget.appBarHeight*/
        ) {
      this.setState(() {
        _isDragging = true;
      });
    }
    //Check use start dragging from top edge / bottom edge then enable dragging
    if (widget.slideDirection == SlideDirection.TOP_TO_BOTTOM &&
        detail.localPosition.dy >= HEIGHT_GESTURE) {
      this.setState(() {
        _isDragging = true;
      });
    }
  }

  void _onHorizontalDragEnd(DragEndDetails detail) {
    if (!widget.isDraggable) return;
    if (_isDragging) {
      openOrClose();
      setState(() {
        _isDragging = false;
      });
    }
  }

  void _onHorizontalDragUpdate(
    DragUpdateDetails detail,
    BoxConstraints constraints,
  ) {
    if (!widget.isDraggable) return;
    // open drawer for left/right type drawer
    if (_isDragging && widget.slideDirection == SlideDirection.LEFT_TO_RIGHT ||
        widget.slideDirection == SlideDirection.RIGHT_TO_LEFT) {
      var globalPosition = detail.globalPosition.dx;
      globalPosition = globalPosition < 0 ? 0 : globalPosition;
      double position = globalPosition / constraints.maxWidth;
      var realPosition = widget.slideDirection == SlideDirection.LEFT_TO_RIGHT
          ? position
          : (1 - position);
      move(realPosition);
    }
    // open drawer for top/bottom type drawer
    /*if (dragging && widget.slideDirection == SlideDirection.TOP_TO_BOTTOM) {
      var globalPosition = detail.globalPosition.dx;
      globalPosition = globalPosition < 0 ? 0 : globalPosition;
      double position = globalPosition / constraints.maxHeight;
      var realPosition = widget.slideDirection == SlideDirection.TOP_TO_BOTTOM
          ? position
          : (1 - position);
      move(realPosition);
    }*/

    // close drawer for left/right type drawer
    if (isDrawerOpen &&
        (widget.slideDirection == SlideDirection.LEFT_TO_RIGHT ||
            widget.slideDirection == SlideDirection.RIGHT_TO_LEFT) &&
        detail.delta.dx < 15) {
      closeSlider();
    }
  }

  move(double percent) {
    _percent = percent;
    _animationDrawerController!.value = percent;
    _animationDrawerController!.notifyListeners();
  }

  openOrClose() {
    if (_percent > 0.3) {
      openSlider();
    } else {
      closeSlider();
    }
  }
}

class _Shadow extends StatelessWidget {
  const _Shadow({
    Key? key,
    required AnimationController? animationDrawerController,
    required this.animation,
    required this.sliderShadow,
    required this.slideDirection,
    required this.sliderOpenSize,
  })  : _animationDrawerController = animationDrawerController,
        super(key: key);

  final AnimationController? _animationDrawerController;
  final Animation animation;
  final SliderShadow sliderShadow;
  final SlideDirection slideDirection;
  final double sliderOpenSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationDrawerController!,
      builder: (_, child) {
        return Transform.translate(
          offset: Utils.getOffsetValueForShadow(
              slideDirection, animation.value, sliderOpenSize),
          child: child,
        );
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
          BoxShadow(
            color: sliderShadow.shadowColor,
            blurRadius: sliderShadow.shadowBlurRadius,
            // soften the shadow
            spreadRadius: sliderShadow.shadowSpreadRadius,
            //extend the shadow
            offset: Offset(
              15.0, // Move to right 15  horizontally
              15.0, // Move to bottom 15 Vertically
            ),
          )
        ]),
      ),
    );
  }
}
