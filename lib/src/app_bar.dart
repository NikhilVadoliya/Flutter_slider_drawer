import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_slider_drawer/src/helper/slider_app_bar.dart';
import 'package:flutter_slider_drawer/src/slider_direction.dart';

class SAppBar extends StatelessWidget {
  final Color splashColor;

  final AnimationController animationController;
  final VoidCallback onTap;
  final SlideDirection slideDirection;

  final SliderAppBar sliderAppBar;

  const SAppBar(
      {Key? key,
      this.splashColor = Colors.black,
      required this.animationController,
      required this.onTap,
      required this.slideDirection,
      required this.sliderAppBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sliderAppBar.appBarHeight,
      padding: sliderAppBar.appBarPadding,
      color: sliderAppBar.appBarColor,
      child: Row(
        children: appBar(),
      ),
    );
  }

  List<Widget> appBar() {
    List<Widget> list = [
      sliderAppBar.drawerIcon ??
          IconButton(
              splashColor: splashColor,
              icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  color: sliderAppBar.drawerIconColor,
                  size: sliderAppBar.drawerIconSize,
                  progress: animationController),
              onPressed: () => onTap()),
      Expanded(
        child: sliderAppBar.isTitleCenter
            ? Center(
                child: sliderAppBar.title,
              )
            : sliderAppBar.title,
      ),
      sliderAppBar.trailing ??
          SizedBox(
            width: 35,
          )
    ];

    if (slideDirection == SlideDirection.RIGHT_TO_LEFT) {
      return list.reversed.toList();
    }
    return list;
  }
}
