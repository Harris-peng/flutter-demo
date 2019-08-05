import 'package:flutter/material.dart';

class GarbageList extends StatefulWidget {
  final List dataList;
  const GarbageList({Key key, this.dataList}) : super(key: key);
  @override
  createState() => new GarbageListState(dataList);
}

class GarbageListState extends State<GarbageList> {
  final _suggestions = [];
  final _saved = new Set<String>();
  final dataList;
  GarbageListState (this.dataList);
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        try {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length && index <= dataList.length) {
            _suggestions.addAll(dataList.sublist(index, (index + 10)));
          }
          return _buildRow(_suggestions[index]);
        } catch (e) {
          print('catch');
          print(dataList);
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