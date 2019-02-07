const topConst = "I'm top const";
//static const topConst2 = "I'm top const";

class TestVar {
  static const classConst = 10086;
  int a;
  int b;

  TestVar({this.a, this.b});

  @override
  String toString() => 'TestVar{a: $a, b: $b}';

  void testPrint() {
    const tmp = 10086;
    print("const in class method:${tmp}");
  }
}

void constPrint() {
  var testVar = TestVar();
  const tmp = "I'm top method const";
  print("const in top field:${topConst}");
  print("const in top method:${tmp}");
  testVar.testPrint();
}

void entrance01() {
  print("enter entrance01");
  constPrint();
  dynamic aTest;
  aTest = 10;
  print("dynamic aTest = ${aTest}");
  aTest = "foo";
  print("dynamic aTest = ${aTest}");

  print("exit entrance01");
}
