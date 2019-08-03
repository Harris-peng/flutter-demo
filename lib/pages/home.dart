import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart'; 
import 'package:myapp/common/utils.dart';

final List<String> _allPages = <String>[
  '干垃圾',
  '湿垃圾',
  '可回收',
  '有害',
];
class TabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new TabBar(
      isScrollable: true,
      labelPadding: EdgeInsets.all(12.0),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: _allPages
          .map((String name) =>
              new Tab(text: name))
          .toList(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar(
        leading: new Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                Utils.getImgPath('tx'),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: new TabLayout(),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                // NavigatorUtil.pushPage(context, new SearchPage(),
                //     pageName: "SearchPage");
                // NavigatorUtil.pushPage(context,  new TestPage());
                //  NavigatorUtil.pushPage(context,  new DemoApp());
              })
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}