# Flutter slider drawer


A Flutter package with custom implementation of the Sider Drawer Menu (Drawer)

![Plugin example demo](demo.gif)




To start using this package, add `fluttersliderdrawer` dependency to your `pubspec.yaml`

```yaml
dependencies:
  fluttersliderdrawer: '<latest_release>'
```

 

# Features

  - Slider with custom animation time
  - Provide Basic Appbar with customization of color, sizes and titles
  - Dynamic slider open and close offset
  - Provide drawer icon animation 

# Code 

```
SliderMenuContainer(
            appBarColor: Colors.white,
            key: _key,
            appBarPadding: const EdgeInsets.only(top: 20),
            sliderMenuOpenOffset: 250,
            appBarHeight: 60,
            title: Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            sliderMenuWidget: MenuWidget(
              onItemClick: (title) {
                _key.currentState.closeDrawer();
                setState(() {
                  this.title = title;
                });
              },
            ),
            sliderMainWidget: MainWidget()),
 ```
