void entrance02() {
  print("enter entrance02");
  bool aBool = false;
  // 注意.和-的优先级
  int wrong = -1.abs();
  int right = (-1).abs();
  print("abs(-1) wrong=${wrong};right=${right}");
  convertBetweenNumAndStr();
  useString();
  useCollection();
  useRunes();

  print("exit entrance02");
}

void useRunes() {
  String unicodeStr = '\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  '
      '\u{1f44d}';

  // String 转 runes
  var runes = unicodeStr.runes;
  runes = new Runes(unicodeStr);
  // runes 转 String
  var string = String.fromCharCodes(runes);

  print("unicode string: ${unicodeStr}");
  print("unicode string in utf16: ${unicodeStr.codeUnits}");
  print("unicode string in utf32: ${unicodeStr.runes.toList()}");
}

void useCollection() {
  List<int> list = [1, 2, 3];
  list[0] = list.length;
  print("list's 0 item = ${list[0]}");

  var constList = const [9, 8, 7];
  print(constList);

  Map<int, String> map = {1: "1", 4: "4"};
  map[10] = "10";
  var tmp = map[4];
  assert(null == map[7]);
  map[1] = map.length.toString();
  var constMap = const {1: 2, 3: 4};
  print(map);
}

void convertBetweenNumAndStr() {
  int aInt = 10;
  double aDouble = 3.1415;
  String aIntStr = "123";
  String aDoubleStr = "5.312";

  var bInt = int.parse(aIntStr);
  var bDouble = double.parse(aDoubleStr);
  var stringFromInt = aInt.toString();
  var stringAsFixed = aDouble.toStringAsFixed(2);
}

void useString() {
  // 1. 单引号 双引号
  var a = 'Single quotes';
  var b = 'Double quotes';
  var c = "I'm ok";
  var d = 'It\'s wrong';

  // 2. 插值表达式
  int x = -100;
  var e = "check i = $x";
  var f = "abs i = ${x.abs()}";

  // 3. 字符重复
  var g = "am${'a' * 10}zing";
  var h = "a${"ma" * 10}zing";

  // 4. 字符串拼接
  var i = "Welcome " 'to ' "China";
  var j = "I'm" + " " + "tired";

  // 5. 多行字符串
  var k = '''
Initializing gradle...
Resolving dependencies...
Gradle task 'assembleDebug'...''';
  var l = """
Performing hot reload...
Syncing files to device Android SDK built for x86...
Reloaded 3 of 422 libraries in 428ms.""";
  // 6. 原始字符串
  var m = r"will not \n start a new line";

  print(
      "use String:\n$a\n\n$b\n\n$c\n\n$d\n\n$e\n\n$f\n\n$g\n\n$h\n\n$i\n\n$j\n\n$k\n\n$l\n\n$m");
}
