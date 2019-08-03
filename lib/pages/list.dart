// Step 7 (Final): Change the app's theme

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'dart:convert';


class GarbageList extends StatefulWidget {
  final num labelId;
  const GarbageList({Key key, this.labelId}) : super(key: key);
  @override
  createState() => new GarbageListState(this.labelId);
}

class GarbageListState extends State<GarbageList> {
  final List countyList = new List();
  final _dryGarbageList = new List();
  final _wetGarbageList = new List();
  final _harmfulGarbageList = new List();
  final _recycleGarbageList = new List();

  final _suggestions = [];
  final _saved = new Set<String>();
  final labelId;
  List _garbageList = [];
  GarbageListState (this.labelId);
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  void initState() {
    super.initState();
    loadData();
  }
  void loadData() async {
    //加载城市列表
    rootBundle.loadString('garbage-classification-data/garbage.json').then((garbage) {
      List countyList = json.decode(garbage);
      countyList.forEach((item) {
        switch (item['categroy']) {
          case 1:
            return _recycleGarbageList.add(item); 
            break;
          case 2:
            return _harmfulGarbageList.add(item); 
            break;
          case 4:
            return _wetGarbageList.add(item); 
            break;
          case 8:
            return _dryGarbageList.add(item); 
            break;
        }
      });
      _garbageList = getGarbage(this.labelId);
      setState(() {});
    });
  }
  List getGarbage (num labelId) {
    switch (labelId) {
      case 1:
        return _recycleGarbageList; //可回收
        break;
      case 2:
        return _harmfulGarbageList; //有害
        break;
      case 4:
        return _wetGarbageList; //湿垃圾
        break;
      case 8:
        return _dryGarbageList; //干垃圾
        break;
      default:
        return new List();
        break;
    }
  }

  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        try {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length && index <= _garbageList.length) {
            _suggestions.addAll(_garbageList.sublist(index, (index + 10)));
          }
          return _buildRow(_suggestions[index]);
        } catch (e) {
          print('catch');
          print(_garbageList);
          print(e);
        }
       
      },
    );
  }

  Widget _buildRow(Map pair) {
    final alreadySaved = _saved.contains(pair['name']);
    return new ListTile(
      title: new Text(
        pair['name'],
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(
              () {
            if (alreadySaved) {
              _saved.remove(pair['name']);
            } else {
              _saved.add(pair['name']);
            }
          },
        );
      },
    );
  }
}
// class Manager {
//   factory Manager() =>_getInstance();
//   static Manager get instance => _getInstance();
//   static Manager _instance;
//   Manager._internal () {
//     print('_internal 11111');
//   }
//   static Manager _getInstance() {
//     if (_instance == null) {
//       _instance = new Manager._internal();
//     }
//     return _instance;
//   }
 
// }
