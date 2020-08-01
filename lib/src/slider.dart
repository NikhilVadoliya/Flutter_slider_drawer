import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class SliderMenuContainer extends StatefulWidget {
  final Widget sliderMenuWidget;
  final Widget sliderMainWidget;
  final int sliderAnimationTimeInMilliseconds;
  final double sliderMenuOpenOffset;
  final double sliderMenuCloseOffset;

  /*final double sliderMainOffset;*/
  final Color drawerIconColor;
  final Widget drawerIcon;
  final double drawerIconSize;
  final double appBarHeight;
  final Widget title;
  final bool isTitleCenter;
  final Widget trailing;
  final Color appBarColor;
  final EdgeInsets appBarPadding;
  final SliderOpen sliderOpen;

  const SliderMenuContainer({
    Key key,
    this.sliderMenuWidget,
    this.sliderMainWidget,
    this.sliderAnimationTimeInMilliseconds = 200,
    this.sliderMenuOpenOffset = 265,
    this.drawerIconColor = Colors.black,
    this.drawerIcon,
    this.isTitleCenter = true,
    this.trailing,
    this.appBarColor = Colors.white,
    this.appBarPadding,
    this.title,
    this.drawerIconSize = 27,
    this.appBarHeight,
    this.sliderMenuCloseOffset = 0,
    this.sliderOpen = SliderOpen.LEFT_TO_RIGHT,
    /* this.sliderMainOffset = 0*/
  })  : assert(sliderMenuWidget != null),
        assert(sliderMainWidget != null),
        super(key: key);

  @override
  SliderMenuContainerState createState() => SliderMenuContainerState();
}

class SliderMenuContainerState extends State<SliderMenuContainer>
    with SingleTickerProviderStateMixin {
  double _slideBarXOffset = 0;
  double _slideBarYOffset = 0;
  bool _isSlideBarOpen = false;
  AnimationController _animationController;

  Widget drawerIcon;
  double db = 0;

  bool get isDrawerOpen => _isSlideBarOpen;

  void toggle() {
    setState(() {
      _isSlideBarOpen
          ? _animationController.reverse()
          : _animationController.forward();
      if (widget.sliderOpen == SliderOpen.LEFT_TO_RIGHT ||
          widget.sliderOpen == SliderOpen.RIGHT_TO_LEFT) {
        _slideBarXOffset = _isSlideBarOpen
            ? widget.sliderMenuCloseOffset
            : widget.sliderMenuOpenOffset;
      } else {
        _slideBarYOffset = _isSlideBarOpen
            ? widget.sliderMenuCloseOffset
            : widget.sliderMenuOpenOffset;
      }

      _isSlideBarOpen = !_isSlideBarOpen;
    });
  }

  void openDrawer() {
    setState(() {
      _animationController.forward();
      if (widget.sliderOpen == SliderOpen.LEFT_TO_RIGHT ||
          widget.sliderOpen == SliderOpen.RIGHT_TO_LEFT) {
        _slideBarXOffset = widget.sliderMenuOpenOffset;
      } else {
        _slideBarYOffset = widget.sliderMenuOpenOffset;
      }
      _isSlideBarOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      _animationController.reverse();
      if (widget.sliderOpen == SliderOpen.LEFT_TO_RIGHT ||
          widget.sliderOpen == SliderOpen.RIGHT_TO_LEFT) {
        _slideBarXOffset = widget.sliderMenuCloseOffset;
      } else {
        _slideBarYOffset = widget.sliderMenuCloseOffset;
      }
      _isSlideBarOpen = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration:
            Duration(milliseconds: widget.sliderAnimationTimeInMilliseconds));
  }

  @override
  Widget build(BuildContext context) {
    getTranslationValues(widget.sliderOpen);
    return Container(
        child: Stack(children: <Widget>[
      menuWidget(),
      AnimatedContainer(
          duration:
              Duration(milliseconds: widget.sliderAnimationTimeInMilliseconds),
          curve: Curves.easeIn,
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          transform: getTranslationValues(widget.sliderOpen),
          child: Column(
            children: <Widget>[
              Container(
                padding: widget.appBarPadding ?? const EdgeInsets.only(top: 24),
                color: widget.appBarColor,
                child: Row(
                  children: appBar(),
                ),
              ),
              Expanded(child: widget.sliderMainWidget),
            ],
          )),
    ]));
  }

  List<Widget> appBar() {
    List<Widget> list = [
      widget.drawerIcon ??
          IconButton(
              icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  color: widget.drawerIconColor,
                  size: widget.drawerIconSize,
                  progress: _animationController),
              onPressed: () {
                toggle();
              }),
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

    if (widget.sliderOpen == SliderOpen.RIGHT_TO_LEFT) {
      return list.reversed.toList();
    }
    return list;
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  menuWidget() {
    switch (widget.sliderOpen) {
      case SliderOpen.LEFT_TO_RIGHT:
        return Container(
          width: widget.sliderMenuOpenOffset,
          child: widget.sliderMenuWidget,
        );
        break;
      case SliderOpen.RIGHT_TO_LEFT:
        return Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: widget.sliderMenuOpenOffset,
            child: widget.sliderMenuWidget,
          ),
        );
      case SliderOpen.TOP_TO_BOTTOM:
        return Positioned(
          right: 0,
          left: 0,
          top: 0,
          child: Container(
            width: widget.sliderMenuOpenOffset,
            child: widget.sliderMenuWidget,
          ),
        );
        break;
    }
    if (widget.sliderOpen == SliderOpen.RIGHT_TO_LEFT) {
    } else {}
  }

  Matrix4 getTranslationValues(SliderOpen sliderOpen) {
    switch (sliderOpen) {
      case SliderOpen.LEFT_TO_RIGHT:
        return Matrix4.translationValues(
            _slideBarXOffset, _slideBarYOffset, 1.0);
      case SliderOpen.RIGHT_TO_LEFT:
        return Matrix4.translationValues(
            -_slideBarXOffset, _slideBarYOffset, 1.0);

      case SliderOpen.TOP_TO_BOTTOM:
        return Matrix4.translationValues(0, _slideBarYOffset, 1.0);

      default:
        return Matrix4.translationValues(0, 0, 1.0);
    }
  }
}
