# Flutter slider drawer

[![pub package](https://img.shields.io/pub/v/flutter_slider_drawer)](https://pub.dev/packages/flutter_slider_drawer)   [![pub package](https://img.shields.io/github/languages/code-size/NikhilVadoliya/Flutter_slider_drawer)](https://pub.dev/packages/flutter_slider_drawer)


A Flutter package with custom implementation of the Slider Drawer Menu 

![Plugin example demo](demo.gif)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="slider_2.gif" alt="drawing" width="250" height="481"/>






To start using this package, add `flutter_slider_drawer` dependency to your `pubspec.yaml`

```yaml
dependencies:
  flutter_slider_drawer: '<latest_release>'
```

 

# Features

  - Slider with custom animation time
  - Provide Basic Appbar with customization of color, size and title
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
           key: _key,
           appBar: SliderAppBar(
               appBarColor: Colors.white,
               title: Text(title,
                   style: const TextStyle(
                       fontSize: 22, fontWeight: FontWeight.w700))),
           slider: Container(color: Colors.red),
           child: Container(color: Colors.amber),
         ));
   }
 ```

</br>
 </br>

 ![slider_document](slider_d_1.png)
 </br>
 </br>
 </br>
 </br>
 
 ![slider_document](slider_d_2.png)

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
  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
      key: _key,
      appBar: SliderAppBar(
          appBarColor: Colors.white,
          title: Text('Title',
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.w700))),
      slider: Container(color: Colors.red),
      child: Container(color: Colors.amber),
    ));
  }
}
      
```

* Using the below methods to control drawer .
``` 
 _key.currentState.closeDrawer();
 _key.currentState.openDrawer();
 _key.currentState.toggle();
 _key.currentState.isDrawerOpen();

 ```
* Use below variable if you want to control animation.


``` _key.currentState.animationController```

License
----

BSD 2-Clause License
