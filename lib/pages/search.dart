import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

final List<Map>  searchList = [
  {"name":"阿司匹林","categroy":2},
  {"name":"阿尔卑斯糖","categroy":4},
  {"name":"艾草","categroy":4},
  {"name":"艾叶","categroy":4},
  {"name":"安全帽","categroy":1},
  {"name":"密胺碗","categroy":1},
  {"name":"密胺餐具","categroy":1},
  {"name":"档案袋","categroy":1},
  {"name":"肮脏塑料袋","categroy":8},
  {"name":"棉袄","categroy":1},
  {"name":"芭蕉叶","categroy":4},
  {"name":"八角","categroy":4},
  {"name":"八宝饭","categroy":4},
  {'name': "liyu",'categroy': 2},
  {'name': "liuyue", 'categroy': 2},
];
final Map<int, String> rabbishs = {
  8: '干垃圾',
  4: '湿垃圾',
  1: '可回收垃圾',
  2: '有害垃圾',
};
const List<Map> recentSuggest = [

  {
    'name': "dangpenghao",
    'categroy': 1,
  },
  {
    'name': "shijunyang",
    'categroy': 4,
  },

];

class SearchBarDelegate extends SearchDelegate<String>{
  //final List data;
  //SearchBarDelegate (this.data);
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
    return Container(
      width: 100.0,
      height:100.0,
      child: Card(
        color:Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }
  //设置推荐
  @override
  Widget buildSuggestions(BuildContext context){
    //print(data.toString());
    final suggestionsList= query.isEmpty
      ? recentSuggest
      : searchList.where((input) {
        final String name = input['name'];
        return name.startsWith(query);
      }).toList();

    return ListView.builder(
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
              ),
              TextSpan(
                text: '<------->' + rabbishs[suggestionsList[index]['categroy']],
                style: TextStyle(color: Colors.grey)
              )
            ]
          ),
        ),
      ),
    );
  }
}