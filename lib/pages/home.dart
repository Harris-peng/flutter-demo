import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';
import 'package:myapp/common/utils.dart';
import 'package:myapp/pages/list.dart';
import 'package:myapp/pages/search.dart';
import 'package:myapp/router/index.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

const TABNAMEKEY = 'tabName';
const TABIDKEY = 'id';
final List<Map> _allPages = <Map>[
  {
    TABNAMEKEY: '干垃圾',
    TABIDKEY: 8
  },
   {
    TABNAMEKEY: '湿垃圾',
    TABIDKEY: 4
  },
   {
    TABNAMEKEY: '可回收垃圾',
    TABIDKEY: 1
  },
   {
    TABNAMEKEY: '有害垃圾',
    TABIDKEY: 2
  },
];

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
     return new DefaultTabController(
      length: _allPages.length,
      child:  Scaffold(
        appBar: new MyAppBar(
          leading: new Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  Utils.getImgPath('tx'),
                ),
                fit: BoxFit.cover,
              ),
            ),
            margin: const EdgeInsets.all(5.0),
          ),
          centerTitle: true,
          title: new TabLayout(),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                // RouteUtil.goSearch(context);
                // final List data = loadData();
                showSearch(context: context,delegate: SearchBarDelegate());
              })
          ],
        ),
        body: new TabBarViewLayout(),
        // floatingActionButton: new FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: new Icon(Icons.add),
        // ),
      )
    );
  }
}

class TabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new TabBar(
      isScrollable: true,
      labelPadding: EdgeInsets.all(12.0),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: _allPages
          .map((Map item) =>
              new Tab(text: item[TABNAMEKEY]))
          .toList(),
    );
  }
}
class TabBarViewLayout extends StatelessWidget {
  Widget buildTabView(BuildContext context, num labelId) {
    return new GarbageList(labelId: labelId);
    // switch (name) {
    //   case '干垃圾':
    //     return new Text(name);
    //     break;
    //   case '湿垃圾':
    //     return ReposPage(labelId: name);
    //     break;
    //   case '可回收':
    //     return EventsPage(labelId: name);
    //     break;
    //   case '有害':
    //     return SystemPage(labelId: name);
    //     break;
    //   default:
    //     return Container();
    //     break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.e("TabBarViewLayout build.......");
    return new TabBarView(
        children: _allPages.map((Map item) {
      return buildTabView(context, item[TABIDKEY]);
    }).toList());
  }
}
// loadData() async {
//   final List searchList = [];
//   //加载城市列表
//   await rootBundle.loadString('garbage-classification-data/garbage.json').then((garbage) {
//     List searchList = json.decode(garbage);
//   });
//   return searchList;
// }