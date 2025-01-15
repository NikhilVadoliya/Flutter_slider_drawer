import 'package:flutter/widgets.dart';

class SliderAppBarConfig {
  /// [Widget] you can set appbar title by this parameter [title]
  ///
  final Widget title;

  ///[Color] you can change appbar color by this parameter [backgroundColor]
  ///
  final Color? backgroundColor;

  ///[EdgeInsets] you can change appBarPadding by this parameter [padding]
  ///
  final EdgeInsets? padding;

  ///[Widget] you can set trailing of appbar by this parameter [trailing]
  ///
  final Widget? trailing;

  ///[Color] you can change drawer icon by this parameter [drawerIconColor]
  ///
  final Color drawerIconColor;

  ///[double] you can change drawer icon size by this parameter [drawerIconSize]
  ///
  final double drawerIconSize;

  ///[bool] true means use cupertino icon of drawer for animation  [isCupertino]
  /// false means use material icon of drawer animation
  /// Default value : false
  final bool isCupertino;

  /// The primary color of the button when the button is in the down (pressed) state.
  /// The splash is represented as a circular overlay that appears above the
  /// [highlightColor] overlay.
  ///
  /// Defaults to the Theme's splash color, [ThemeData.splashColor].
  final Color? splashColor;

  const SliderAppBarConfig(
      {this.title = const Text('AppBar'),
      this.backgroundColor,
      this.padding,
      this.trailing,
      this.drawerIconColor = const Color(0xff2c2b2b),
      this.drawerIconSize = 27,
      this.isCupertino = false,
      this.splashColor});

  /// Creates a copy of this configuration with the given fields replaced
  SliderAppBarConfig copyWith(
      {double? height,
      Widget? title,
      bool? isTitleCenter,
      Color? backgroundColor,
      EdgeInsets? padding,
      Widget? trailing,
      Color? drawerIconColor,
      Widget? drawerIcon,
      double? drawerIconSize,
      double? elevation,
      bool? isCupertino,
      Color? splashColor}) {
    return SliderAppBarConfig(
      title: title ?? this.title,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      padding: padding ?? this.padding,
      trailing: trailing ?? this.trailing,
      drawerIconColor: drawerIconColor ?? this.drawerIconColor,
      drawerIconSize: drawerIconSize ?? this.drawerIconSize,
      isCupertino: isCupertino ?? this.isCupertino,
      splashColor: splashColor ?? this.splashColor,
    );
  }
}
