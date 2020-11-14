import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/src/app_bar.dart';
import 'package:flutter_slider_drawer/src/menu_bar.dart';
import 'package:flutter_slider_drawer/src/helper/utils.dart';
import 'package:flutter_slider_drawer/src/slider_direction.dart';

class SliderMenuContainer extends StatefulWidget {
  final Widget sliderMenu;
  final Widget sliderMain;
  final int animationDuration;
  final double sliderMenuOpenSize;
  final double sliderMenuCloseSize;

  final bool hasAppBar;
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
    this.appBarHeight = 70,
    this.sliderMenuCloseSize = 0,
    this.slideDirection = SlideDirection.LEFT_TO_RIGHT,
    this.isShadow = false,
    this.shadowColor = Colors.grey,
    this.shadowBlurRadius = 25.0,
    this.shadowSpreadRadius = 5.0,
    this.hasAppBar = true,
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

  /// it's provide [animationController] for handle and lister drawer animation
  AnimationController get animationController => _animationDrawerController;

  /// Toggle drawer
  void toggle() => _animationDrawerController.isCompleted
      ? _animationDrawerController.reverse()
      : _animationDrawerController.forward();

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
      SlideMenuBar(
        slideDirection: widget.slideDirection,
        sliderMenu: widget.sliderMenu,
        sliderMenuOpenSize: widget.sliderMenuOpenSize,
      ),

      /// Displaying the  shadow
      if (widget.isShadow) ...[
        AnimatedBuilder(
          animation: _animationDrawerController,
          builder: (anim, child) {
            return Transform.translate(
              offset: Utils.getOffsetValueForShadow(widget.slideDirection,
                  animation.value, widget.sliderMenuOpenSize),
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
                  15.0, // Move to right 15  horizontally
                  15.0, // Move to bottom 15 Vertically
                ),
              )
            ]),
          ),
        ),
      ],

      //Display Main Screen
      AnimatedBuilder(
        animation: _animationDrawerController,
        builder: (anim, child) {
          return Transform.translate(
            offset:
                Utils.getOffsetValues(widget.slideDirection, animation.value),
            child: child,
          );
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: widget.appBarColor,
          child: Column(
            children: <Widget>[
              if (widget.hasAppBar)
                SliderAppBar(
                  slideDirection: widget.slideDirection,
                  onTap: () => toggle(),
                  appBarHeight: widget.appBarHeight,
                  animationController: _animationDrawerController,
                  appBarColor: widget.appBarColor,
                  appBarPadding: widget.appBarPadding,
                  drawerIcon: widget.drawerIcon,
                  drawerIconColor: widget.drawerIconColor,
                  drawerIconSize: widget.drawerIconSize,
                  isTitleCenter: widget.isTitleCenter,
                  splashColor: widget.splashColor,
                  title: widget.title ?? '',
                  trailing: widget.trailing,
                ),
              Expanded(child: widget.sliderMain),
            ],
          ),
        ),
      ),
    ]));
  }

  @override
  void dispose() {
    super.dispose();
    _animationDrawerController.dispose();
  }
}
