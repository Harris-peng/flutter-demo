import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flustars/flustars.dart';

import 'package:myapp/common/utils.dart';
import 'package:myapp/pages/list.dart';
import 'package:myapp/pages/search.dart';

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
    TABNAMEKEY: '有害垃圾',
    TABIDKEY: 2
  },
   {
    TABNAMEKEY: '可回收垃圾',
    TABIDKEY: 1
  },
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final List countyList = new List();
  final List _dryGarbageList = new List(); // 干垃圾
  final List _wetGarbageList = new List(); // 湿垃圾
  final List _harmfulGarbageList = new List(); // 有害垃圾
  final List _recycleGarbageList = new List(); // 可回收垃圾

   Future<Null> loadData() async {
    //加载城市列表
    rootBundle.loadString('garbage-classification-data/garbage.json').then((garbage) {
      List countyList = json.decode(garbage);
      countyList.forEach((item) {
        switch (item['categroy']) {
          case 1:
            _recycleGarbageList.add(item); 
            break;
          case 2:
            _harmfulGarbageList.add(item); 
            break;
          case 4:
            _wetGarbageList.add(item); 
            break;
          case 8:
            _dryGarbageList.add(item); 
            break;
        }
      });
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    loadData();
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
                print(countyList.toString());
                // RouteUtil.goSearch(context);
                // final List data = loadData();
                showSearch(context: context,delegate: SearchBarDelegate(countyList));
              })
          ],
        ),
        body: new TabBarViewLayout(_dryGarbageList, _wetGarbageList, _harmfulGarbageList, _recycleGarbageList),
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
  final List _dryGarbageList;
  final List _wetGarbageList;
  final List _harmfulGarbageList;
  final List _recycleGarbageList;

  TabBarViewLayout(this._dryGarbageList, this._wetGarbageList, this._harmfulGarbageList, this._recycleGarbageList);
  
  Widget buildTabView(BuildContext context, num labelId) {
    switch (labelId) {
      case 8:
        return new GarbageList(dataList: _dryGarbageList);
        break;
      case 4:
        return new GarbageList(dataList: _wetGarbageList);
        break;
      case 2:
        return new GarbageList(dataList: _harmfulGarbageList);
        break;
      case 1:
        return new GarbageList(dataList: _recycleGarbageList);
        break;
      default:
        return Container();
        break;
    }
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