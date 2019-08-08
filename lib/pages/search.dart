import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

final Map<int, String> rabbishs = { 
  8: '干垃圾',
  4: '湿垃圾',
  1: '可回收垃圾',
  2: '有害垃圾',
};

class SearchBarDelegate extends SearchDelegate<String>{
  Future<List> loadData() async {
      final dataList = await rootBundle.loadString('garbage-classification-data/garbage.json');
      return json.decode(dataList);
  }
  //清空按钮
  @override
  List<Widget>buildActions(BuildContext context){
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "", //搜索值为空
      )
    ];
  }
  //返回上级按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, progress: transitionAnimation
      ),
      onPressed: () => close(context, null)  //点击时关闭整个搜索页面
    );
  }
  //搜到到内容后的展现
  @override
  Widget buildResults(BuildContext context){
    return buildFutureBuilder();
  }
  //设置推荐
  @override
  Widget buildSuggestions (BuildContext context) {
    return buildFutureBuilder();
  }
  FutureBuilder<List> buildFutureBuilder() {
    return new FutureBuilder<List>(
      builder: (context, AsyncSnapshot<List> result) {
        if (result.connectionState == ConnectionState.active ||
            result.connectionState == ConnectionState.waiting) {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
        if (result.connectionState == ConnectionState.done) {
          if (result.hasError) {
            return new Center(
              child: new Text("ERROR"),
            );
          } else if (result.hasData) {
            List suggestionsList = result.data;
            if (query != '') {
              suggestionsList = suggestionsList.where((item) =>  item['name'].startsWith(query)).toList();
            } else {
              suggestionsList = [];
            }
            print(suggestionsList.length);
            return suggestionsList.length != 0 ? ListView.builder(
              itemCount:suggestionsList.length,
              itemBuilder: (context,index) => ListTile(
                title: RichText( //富文本
                  text: TextSpan(
                    text: suggestionsList[index]['name'].substring(0,query.length),
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: suggestionsList[index]['name'].substring(query.length),
                        style: TextStyle(color: Colors.grey)
                      )
                    ]
                  ),
                ),
                trailing: query != '' ? Text(rabbishs[suggestionsList[index]['categroy']],
                  style: TextStyle(color: Colors.grey)
                ) : '',
              ),
            ) : new Center(
              child: new Text("暂无内容"),
            );
          }
        }
      },
      future: loadData(),
    );
  }
}