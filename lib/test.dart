
main() async {
  List<Function> list = [];
  for(var i = 0; i<5; i++) {
    list.add(() => print(i));
  }
  list.forEach((i) => i());
  Runes input = new Runes(
      '\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}');
  print(new String.fromCharCodes(input));
}