import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

abstract class BaseSliderAppBar extends StatelessWidget {
  // Configuration for the app bar's appearance and behavior
  final SliderAppBarConfig config;

  /// Callback function when the drawer icon is tapped
  final VoidCallback? onDrawerTap;

  const BaseSliderAppBar({
    Key? key,
    required this.config,
    this.onDrawerTap,
  }) : super(key: key);
}

class SliderAppBar extends BaseSliderAppBar {
  const SliderAppBar({
    Key? key,
    required SliderAppBarConfig config,
  }) : super(key: key, config: config);

  @override
  Widget build(BuildContext context) {
    // This build method won't be used directly
    throw UnimplementedError('SliderAppBar cannot be used directly');
  }
}

class _InternalSliderAppBar extends BaseSliderAppBar
    implements PreferredSizeWidget {
  /// Animation controller for drawer sliding effect
  final AnimationController animationController;
  final SlideDirection slideDirection;

  const _InternalSliderAppBar({
    required SliderAppBarConfig config,
    required this.animationController,
    required this.slideDirection,
    VoidCallback? onDrawerTap,
  }) : super(config: config, onDrawerTap: onDrawerTap);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      _LeadingIcon(
        onTap: onDrawerTap,
        animationController: animationController,
        config: config,
      ),
      Expanded(child: config.title),
      config.trailing ?? SizedBox(width: 35)
    ];

    if (slideDirection == SlideDirection.rightToLeft)
      items = items.reversed.toList();

    return Container(
      height: kToolbarHeight,
      padding: config.padding,
      color: config.backgroundColor ?? Color(0xFFFFFFFF),
      child: Row(children: items),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _LeadingIcon extends StatelessWidget {
  final SliderAppBarConfig config;
  final AnimationController animationController;
  final VoidCallback? onTap;

  const _LeadingIcon(
      {required this.config,
      required this.animationController,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return config.isCupertino
        ? _AnimatedCupertinoIcon(progress: animationController, onTap: onTap)
        : IconButton(
            splashColor: config.splashColor,
            icon: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                color: config.drawerIconColor,
                size: config.drawerIconSize,
                progress: animationController),
            onPressed: onTap);
  }
}

class _AnimatedCupertinoIcon extends StatelessWidget {
  final Animation<double> progress;
  final VoidCallback? onTap;

  const _AnimatedCupertinoIcon(
      {Key? key, required this.progress, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder<double>(
          valueListenable: progress,
          builder: (context, progressValue, child) {
            final isCompleted = progress.isCompleted;
            return Icon(
              isCompleted
                  ? CupertinoIcons.clear_thick
                  : CupertinoIcons.line_horizontal_3,
              color: Colors.grey,
              size: 25.0,
            );
          },
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  final Widget? appBar;
  final AnimationController animationDrawerController;
  final VoidCallback? onDrawerTap;
  final SlideDirection slideDirection;

  const AppBar({
    this.appBar,
    required this.animationDrawerController,
    this.onDrawerTap,
    required this.slideDirection,
  });

  @override
  Widget build(BuildContext context) {
    if (appBar == null) {
      return _InternalSliderAppBar(
        config: SliderAppBarConfig(),
        onDrawerTap: onDrawerTap,
        slideDirection: slideDirection,
        animationController: animationDrawerController,
      );
    }
    if (appBar is SliderAppBar) {
      final sliderAppBar = appBar as SliderAppBar;

      return _InternalSliderAppBar(
        animationController: animationDrawerController,
        config: sliderAppBar.config,
        slideDirection: slideDirection,
        onDrawerTap: onDrawerTap,
      );
    }
    return SizedBox.shrink();
  }
}
