import 'package:flutter/material.dart';
import 'package:myapp/common/const.dart';
import 'package:myapp/pages/index.dart';
import 'package:myapp/pages/search.dart';
import 'package:myapp/pages/splash.dart';
import 'package:flustars/flustars.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  // @override
  // void initState() {
  //   super.initState();
  //   _initAsync();
  // }
 
  // void _initAsync() async {
  //   await SpUtil.getInstance();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
      routes: {
       RouteName.home: (ctx) => NavigationKeepAlive(),
       RouteName.search: (ctx) => SearchPage(),
      },
      title: 'Flutter bottomNavigationBar',
      theme: new ThemeData.light(),
      // home: NavigationKeepAlive(),
      home: new SplashPage(),
    );
  }
}
