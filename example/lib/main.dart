import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fluttersliderdrawer/flutter_slider_drawer.dart';
import 'package:fluttersliderdrawer_example/main_widget.dart';
import 'package:fluttersliderdrawer_example/menu_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();
  String title;

  @override
  void initState() {
    title = "Home";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SliderMenuContainer(
            appBarColor: Colors.white,
            key: _key,
            appBarPadding: const EdgeInsets.only(top: 20),
            sliderMenuOpenOffset: 250,
//            sliderMenuCloseOffset: 50,
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
      ),
    );
  }
}
