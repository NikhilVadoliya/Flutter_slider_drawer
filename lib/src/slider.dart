import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class SliderMenuContainer extends StatefulWidget {
  final Widget sliderMenu;
  final Widget sliderMain;
  final int animationDuration;
  final double sliderMenuOpenSize;
  final double sliderMenuCloseSize;

  final Color drawerIconColor;
  final Widget drawerIcon;
  final double drawerIconSize;
  final Color splashColor;
  final double appBarHeight;
  final Widget title;
  final bool isTitleCenter;
  final bool isShadow;
  final Color shadowColor;
  final double shadowBlurRadius;
  final double shadowSpreadRadius;

  final Widget trailing;
  final Color appBarColor;
  final EdgeInsets appBarPadding;
  final SlideDirection slideDirection;

  const SliderMenuContainer({
    Key key,
    this.sliderMenu,
    this.sliderMain,
    this.animationDuration = 200,
    this.sliderMenuOpenSize = 265,
    this.drawerIconColor = Colors.black,
    this.drawerIcon,
    this.splashColor,
    this.isTitleCenter = true,
    this.trailing,
    this.appBarColor = Colors.white,
    this.appBarPadding,
    this.title,
    this.drawerIconSize = 27,
    this.appBarHeight,
    this.sliderMenuCloseSize = 0,
    this.slideDirection = SlideDirection.LEFT_TO_RIGHT,
    this.isShadow = false,
    this.shadowColor = Colors.grey,
    this.shadowBlurRadius = 25.0,
    this.shadowSpreadRadius = 5.0,
  })  : assert(sliderMenu != null),
        assert(sliderMain != null),
        super(key: key);

  @override
  SliderMenuContainerState createState() => SliderMenuContainerState();
}

class SliderMenuContainerState extends State<SliderMenuContainer>
    with TickerProviderStateMixin {
  AnimationController _animationDrawerController;
  Animation animation;

  Widget drawerIcon;

  /// check whether drawer is open
  bool get isDrawerOpen => _animationDrawerController.isCompleted;

  AnimationController get animationController => _animationDrawerController;

  /// Toggle drawer
  void toggle() {
    _animationDrawerController.isCompleted
        ? _animationDrawerController.reverse()
        : _animationDrawerController.forward();
  }

  /// Open drawer
  void openDrawer() => _animationDrawerController.forward();

  /// Close drawer
  void closeDrawer() => _animationDrawerController.reverse();

  @override
  void initState() {
    super.initState();

    _animationDrawerController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration));

    animation = Tween<double>(
            begin: widget.sliderMenuCloseSize, end: widget.sliderMenuOpenSize)
        .animate(CurvedAnimation(
            parent: _animationDrawerController,
            curve: Curves.easeIn,
            reverseCurve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
      /// Display Menu
      menuWidget(),

      /// Dev -Displaying the  shadow
      if (widget.isShadow) ...[
        AnimatedBuilder(
          animation: _animationDrawerController,
          builder: (anim, child) {
            return Transform.translate(
              offset: getOffsetValueForShadow(
                  widget.slideDirection, animation.value),
              child: child,
            );
            return child;
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
              BoxShadow(
                color: widget.shadowColor,
                blurRadius: widget.shadowBlurRadius, // soften the shadow
                spreadRadius: widget.shadowSpreadRadius, //extend the shadow
                offset: Offset(
                  15.0, // Move to right 10  horizontally
                  15.0, // Move to bottom 10 Vertically
                ),
              )
            ]),
          ),
        ),
      ],

      //Dev- Display Main Screen
      AnimatedBuilder(
        animation: _animationDrawerController,
        builder: (anim, child) {
          return Transform.translate(
            offset: getOffsetValues(widget.slideDirection, animation.value),
            child: child,
          );
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: widget.appBarColor,
          child: Column(
            children: <Widget>[
              Container(
                padding: widget.appBarPadding ?? const EdgeInsets.only(top: 24),
                color: widget.appBarColor,
                child: Row(
                  children: appBar(),
                ),
              ),
              Expanded(child: widget.sliderMain),
            ],
          ),
        ),
      ),
    ]));
  }

  List<Widget> appBar() {
    List<Widget> list = [
      widget.drawerIcon ??
          IconButton(
              splashColor: widget.splashColor ?? Colors.black,
              icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  color: widget.drawerIconColor,
                  size: widget.drawerIconSize,
                  progress: _animationDrawerController),
              onPressed: () => toggle()),
      Expanded(
        child: widget.isTitleCenter
            ? Center(
                child: widget.title,
              )
            : widget.title,
      ),
      widget.trailing ??
          SizedBox(
            width: 35,
          )
    ];

    if (widget.slideDirection == SlideDirection.RIGHT_TO_LEFT) {
      return list.reversed.toList();
    }
    return list;
  }

  /// Build and Align the Menu widget based on the slide open type
  menuWidget() {
    switch (widget.slideDirection) {
      case SlideDirection.LEFT_TO_RIGHT:
        return Container(
          width: widget.sliderMenuOpenSize,
          child: widget.sliderMenu,
        );
        break;
      case SlideDirection.RIGHT_TO_LEFT:
        return Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: widget.sliderMenuOpenSize,
            child: widget.sliderMenu,
          ),
        );
      case SlideDirection.TOP_TO_BOTTOM:
        return Positioned(
          right: 0,
          left: 0,
          top: 0,
          child: Container(
            width: widget.sliderMenuOpenSize,
            child: widget.sliderMenu,
          ),
        );
        break;
    }
  }

  ///
  /// This method get Offset base on [sliderOpen] type
  ///

  Offset getOffsetValues(SlideDirection direction, double value) {
    switch (direction) {
      case SlideDirection.LEFT_TO_RIGHT:
        return Offset(value, 0);
      case SlideDirection.RIGHT_TO_LEFT:
        return Offset(-value, 0);
      case SlideDirection.TOP_TO_BOTTOM:
        return Offset(0, value);
      default:
        return Offset(value, 0);
    }
  }

  Offset getOffsetValueForShadow(SlideDirection direction, double value) {
    switch (direction) {
      case SlideDirection.LEFT_TO_RIGHT:
        return Offset(value - (widget.sliderMenuOpenSize > 50 ? 20 : 10), 0);
      case SlideDirection.RIGHT_TO_LEFT:
        return Offset(-value - 5, 0);
      case SlideDirection.TOP_TO_BOTTOM:
        return Offset(0, value - (widget.sliderMenuOpenSize > 50 ? 15 : 5));
      default:
        return Offset(value - 30.0, 0);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationDrawerController.dispose();
  }
}
