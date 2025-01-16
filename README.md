# Flutter Slider Drawer

<img src="banner.png" alt="drawing"/>

[![pub package](https://img.shields.io/pub/v/flutter_slider_drawer)](https://pub.dev/packages/flutter_slider_drawer)   [![pub package](https://img.shields.io/github/languages/code-size/NikhilVadoliya/Flutter_slider_drawer)](https://pub.dev/packages/flutter_slider_drawer)


A Flutter package with custom implementation of the Slider Drawer Menu 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="intro.gif" alt="drawing" width="290" height="640"/>






To start using this package, add `flutter_slider_drawer` dependency to your `pubspec.yaml`

```yaml
dependencies:
  flutter_slider_drawer: '<latest_release>'
```

# Features

  - Slider with custom animation time
  - Provide Basic Appbar with customization of color and title
  - Dynamic slider open and close offset
  - Provide drawer icon animation 
  - Provide shadow of Main screen with customization of shadow colors,blurRadius and spreadRadius
  - Provide RTL(RightToLeft),LTR(LeftToRight) and TTB(TopToBottom) slider open selection
  - Provide Custom Appbar support and you can also use plugin appBar with use of `SliderAppBar` widget
  - If you are using CupertinoApp then pass `isCupertino: true`


# Code 

```
Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
      key: _sliderDrawerKey,
      appBar: SliderAppBar(
        config: SliderAppBarConfig(
            title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        )),
      ),
      sliderOpenSize: 179,
      slider: Container(color: Colors.red),
      child: Container(color: Colors.amber),
    ));
  }
 ```

</br>
 </br>

 ![slider_document](information.png)
 </br>
 </br>
 </br>
 </br>


 # Slider open  

 | SliderOpen.LEFT_TO_RIGHT  | SliderOpen.RIGHT_TO_LEFT  | SliderOpen.TOP_TO_BOTTOM  |
 |---|---|---|
 | ![slider_left](slide_left.gif)  | ![slider_right](slide_right.gif)  | ![slider_top](slide_top.gif)  |
 
 
 
 </br>

### Controlling the drawer

```
class _MyAppState extends State<MyApp> {
  GlobalKey<SliderDrawerState> _sliderDrawerKey = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
      key: _sliderDrawerKey,
      appBar: SliderAppBar(
        config: SliderAppBarConfig(
            title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
       ),
      ),
      sliderOpenSize: 179,
      slider: Container(color: Colors.red),
      child: Container(color: Colors.amber),
    ));
  }
}
      
```

* Using the below methods to control drawer .
``` 
 _sliderDrawerKey.currentState.closeDrawer();
 _sliderDrawerKey.currentState.openDrawer();
 _sliderDrawerKey.currentState.toggle();
 _sliderDrawerKey.currentState.isDrawerOpen();

 ```
* Use below variable if you want to control animation.


``` __sliderDrawerKey.currentState.animationController```

# Contribute to Development
Your contribution will help improve the plugin

<a href="https://www.buymeacoffee.com/nick94" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>


License
----

BSD 2-Clause License
