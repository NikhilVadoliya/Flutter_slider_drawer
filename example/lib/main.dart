import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fluttersliderdrawer/fluttersliderdrawer.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SliderMenuContainer(
            key: _key,
            appBarPadding: const EdgeInsets.only(top: 30),
            sliderMenuOffset: 250,
            titleTextStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            sliderMenuWidget: MenuWidget(
              onItemClick: () {
                _key.currentState.closeDrawer();
              },
            ),
            sliderMainWidget: MainWidget()),
      ),
    );
  }
}
