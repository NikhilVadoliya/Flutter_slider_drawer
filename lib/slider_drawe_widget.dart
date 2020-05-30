import 'package:flutter/material.dart';

class SliderMenuContainer extends StatefulWidget {
  final Widget sliderMenuWidget;
  final Widget sliderMainWidget;
  final int sliderAnimationTimeInMilliseconds;
  final double sliderMenuOffset;

  /*final double sliderMainOffset;*/
  final Color drawerIconColor;
  final Widget drawerIcon;
  final TextStyle titleTextStyle;
  final bool isTitleCenter;
  final Widget trailing;
  final Color appBarColor;
  final EdgeInsets appBarPadding;

  const SliderMenuContainer({
    Key key,
    this.sliderMenuWidget,
    this.sliderMainWidget,
    this.sliderAnimationTimeInMilliseconds = 200,
    this.sliderMenuOffset = 265,
    this.drawerIconColor = Colors.black,
    this.drawerIcon,
    this.titleTextStyle,
    this.isTitleCenter = true,
    this.trailing,
    this.appBarColor = Colors.white,
    this.appBarPadding,
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
  double _pageScale = 1;

  Widget drawerIcon;
  double db = 0;

  bool get isDrawerOpen => _isSlideBarOpen;

  void toggle() {
    setState(() {
      _isSlideBarOpen
          ? _animationController.forward()
          : _animationController.reverse();
      _slideBarXOffset = _isSlideBarOpen ? widget.sliderMenuOffset : 0;
      //  _slideBarYOffset = _isSlideBarOpen ? widget.sliderMainOffset : 0;
      _pageScale = _isSlideBarOpen ? 0.8 : 1;
    });
  }

  void openDrawer() {
    setState(() {
      _animationController.forward();
      _slideBarXOffset = widget.sliderMenuOffset;
      //     _slideBarYOffset = widget.sliderMainOffset;
      _pageScale = 0.8;
    });
  }

  void closeDrawer() {
    setState(() {
      _animationController.reverse();
      _slideBarXOffset = 0;
      _slideBarYOffset = 0;
      _pageScale = 1;
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
    return Container(
      child: Container(
          child: Stack(children: <Widget>[
        Container(
          width: widget.sliderMenuOffset,
          child: widget.sliderMenuWidget,
        ),
        AnimatedContainer(
            padding: widget.appBarPadding ?? const EdgeInsets.only(top: 24),
            duration: Duration(
                milliseconds: widget.sliderAnimationTimeInMilliseconds),
            curve: Curves.easeIn,
            width: double.infinity,
            height: double.infinity,
            transform: Matrix4.translationValues(
                _slideBarXOffset, _slideBarYOffset, 1.0),
            color: widget.appBarColor,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    widget.drawerIcon ??
                        IconButton(
                            icon: AnimatedIcon(
                                icon: AnimatedIcons.menu_close,
                                color: widget.drawerIconColor,
                                progress: _animationController),
                            onPressed: () {
                              _isSlideBarOpen = !_isSlideBarOpen;
                              toggle();
                            }),
                    Expanded(
                      child: widget.isTitleCenter
                          ? Center(
                              child: _titleWidget(),
                            )
                          : _titleWidget(),
                    ),
                    widget.trailing ??
                        SizedBox(
                          width: 35,
                        )
                  ],
                ),
                Expanded(child: widget.sliderMainWidget),
              ],
            )),
      ])),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  _titleWidget() => Text(
        'Title',
        textAlign: TextAlign.center,
        style: widget.titleTextStyle ?? TextStyle(color: Colors.black),
      );
}
