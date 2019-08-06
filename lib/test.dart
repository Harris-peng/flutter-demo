
main() async {
  const recentSuggest = [
    {
      "name": "测试1",
      'categroy': 2,
    },
    {
      "name": "测试2",
      'categroy': 2,
    }
  ];
  List test = [];
  test = recentSuggest.where((input) {
    //print(input.toString());
    final String name = input['name'];
    return name.startsWith('测试1');
  }).toList();
  print(test.toString());
}