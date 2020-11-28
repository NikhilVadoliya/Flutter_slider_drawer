# Flutter slider drawer

[![pub package](https://img.shields.io/pub/v/flutter_slider_drawer)](https://pub.dev/packages/flutter_slider_drawer)   [![pub package](https://img.shields.io/github/languages/code-size/NikhilVadoliya/Flutter_slider_drawer)](https://pub.dev/packages/flutter_slider_drawer)


A Flutter package with custom implementation of the Slider Drawer Menu 

![Plugin example demo](demo.gif)






To start using this package, add `flutter_slider_drawer` dependency to your `pubspec.yaml`

```yaml
dependencies:
  flutter_slider_drawer: '<latest_release>'
```

 

# Features

  - Slider with custom animation time
  - Provide Basic Appbar with customization of color, sizes and title
  - Dynamic slider open and close offset
  - Provide drawer icon animation 
  - Provide shadow of Main screen with customization of shadow colors,blurRadius and spreadRadius
  - Provide RTL(RightToLeft),LTR(LeftToRight) and TTB(TopToBottom) slider open selection 

# Code 

```
 Scaffold(
        body:SliderMenuContainer(
              appBarColor: Colors.white,
              key: _key,
              sliderMenuOpenSize: 200,
              title: Text(
                title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              sliderMenu: MenuWidget(
                onItemClick: (title) {
                  _key.currentState.closeDrawer();
                  setState(() {
                    this.title = title;
                  });
                },
              ),
              sliderMain: MainWidget()),
      ),
 ```
 
 
 
 # Slider open  

 | SliderOpen.LEFT_TO_RIGHT  | SliderOpen.RIGHT_TO_LEFT  | SliderOpen.TOP_TO_BOTTOM  |
 |---|---|---|
 | ![slider_left](slide_left.gif)  | ![slider_right](slide_right.gif)  | ![slider_top](slide_top.gif)  |
 
 
 
 
### Controlling the drawer

```
GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();
  
   @override
  Widget build(BuildContext context) {
  return SliderMenuContainer(
              appBarColor: Colors.white,
              key: _key,
              sliderMenuOpenSize: 200,
              sliderMenu: MenuWidget(
                onItemClick: (title) {
                  _key.currentState.closeDrawer();
                  setState(() {
                    this.title = title;
                  });
                },
              ),
              sliderMain: MainWidget()),
      
```

* Using the below methods for controll drawer .
``` 
 _key.currentState.closeDrawer();
 _key.currentState.openDrawer();
 _key.currentState.toggle();
 _key.currentState.isDrawerOpen();

 ```
* Use below variable if you want to controlle animation.


``` _key.currentState.animationController```

License
----

BSD 2-Clause License

