import 'package:flutter/material.dart';
import 'package:myapp/common/const.dart';
import 'package:myapp/pages/index.dart';
import 'package:myapp/pages/splash.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      routes: {
       RouteName.home: (ctx) => NavigationKeepAlive(),
       // RouteName.search: (ctx) => SearchPage(),
      },
      title: 'Flutter bottomNavigationBar',
      theme: new ThemeData.light(),
      home: new SplashPage(),
    );
  }
}
