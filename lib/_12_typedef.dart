void entrance12() {
  print("enter entrance12");
  testTypedef();
  print("exit entrance12");
}

void testTypedef() {
  var noTypeDef = TestNoTypeDef(testFunc);
  var typeDef = TestTypeDef(testFunc);

  // 直接使用函数或者使用typedef声明的Function对象，使用参数时会验证参数
  //  print(testFunc(112, "haha", 1));
  //  print(typeDef.func(14, "thx", 4));

  // 不使用typedef声明的Function对象，在使用参数时不验证参数，不安全
  try {
    print(noTypeDef.func(112, "haha", 2));
  } catch (e) {
    print(e);
  }

  print(testFunc(111, "blue"));
  print(typeDef.func(14, "thx"));
}

class TestNoTypeDef {
  // func只是定义为Function的一个对象，不含有具体函数的签名信息
  Function func;

  // f含有函数的签名信息，但是分配给func后，其签名信息就丢失了
  TestNoTypeDef(String f(int a, String b)) {
    func = f;
  }
}

String testFunc(int a, String b) => "${b} with a number ${a}";

typedef TYPE_TEST_FUNC = String Function(int a, String b);

class TestTypeDef {
  TYPE_TEST_FUNC func;

  TestTypeDef(this.func);
}
