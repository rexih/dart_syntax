entrance06() {
  print("enter entrance06");
  testClassFeature();
  testConstCtor();
  print("exit entrance06");
}

void testClassFeature() {
  // 默认未命名构造函数方式实例化
  var test = Test();
  // 命名构造函数实例化
  var testFeature = TestFeature.fromTest(test);
  // .操作符使用类/对象的成员
  testFeature._f = 20;
  Test tChild = TestChild();
  // runtimeType获取实际类型；_成员可以强制访问
  print("test:${test.runtimeType};tChild:${tChild.runtimeType};"
      "testFeature:${testFeature.runtimeType},${testFeature.e},f=${testFeature._f}");

  var a = TestNoCtorChild();
  var b = TestNoCtorChild(id: 11);
  var c = TestNoCtorChild.withName("dodo");
  var d = TestNoCtorChild.testInitList();
  print("a.id:${a.id};b.id:${b.id}");
}

void testConstCtor() {
  // 构建常量实例必须使用定义的常量构造函数，如果不是常量构造函数是无法再实例化时使用const修饰符
  // The constructor being called isn't a const constructor
  //  var test2 = const Test();
  var constObj1 = const TestConstCtor(1);
  var constObj2 = const TestConstCtor(2);
  var constObj2_2 = const TestConstCtor(2);
  // 如果实例化时不加const修饰符，即使调用的是声明为const的构造函数，实例化的也不是常量实例
  var constObj2_3 = TestConstCtor(2);

  print(
      "const TestConstCtor(1) and const TestConstCtor(2) same: ${identical(constObj1, constObj2)}");

  print(
      "const TestConstCtor(2) and const TestConstCtor(2) same: ${identical(constObj2_2, constObj2)}");

  print(
      "TestConstCtor(2) and const TestConstCtor(2) same: ${identical(constObj2_2, constObj2_3)}");
}

class TestConstCtor {
  final int x;

  // const构造函数必须用于成员变量都是final的类
  // Can't define a constructor for a class with non-final fields
//  String y;
  const TestConstCtor(this.x);
}

class TestFeature {
  int c;
  int d;

  int _f;

  // 计算属性的get / set
  int get e => c + d;

  set e(int newE) {
    c = e - 1;
    d = 1;
  }

  TestFeature({this.c, this.d});

  TestFeature.fromTest(Test test) {
    c = 10 + test.a;
    d = 20 + test.b;
  }
}

class Test {
  int a = 5;
  int b = 3;
}

class TestChild extends Test {
  int c = 7;
}

class TestParamCtor {
  int id;

  TestParamCtor(this.id);

  TestParamCtor.fromName(String name) {
    id = null == name ? 0 : name.length;
  }
}

class TestNoCtorChild extends TestParamCtor {
  String desc;
  String name;

  TestNoCtorChild({int id}) : super(id ??= 12);

  TestNoCtorChild.withName(String name) : super.fromName(convertName(name));

  TestNoCtorChild.testInitList()
      : desc = "rexih",
//        this(id:123)
        super(13)
//        , name = "rexih2"
  {}

  static String convertName(String name) => name.toUpperCase();
}
