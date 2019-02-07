entrance03() {
  print("enter entrance03");
  print(testSingleLine());

  print(testParamNoType(2));
//  print(testParamNoType('r'));
//  print(testParamNoTypeCompare('r'));
//  print(testParamNoType(null));
  testVA();
  print(testEmptyReturn());
  testFunction();
  testAnonymousFunction();
  testNestedFunction();
  testClosureArgument();
  print("exit entrance03");
}

testSingleLine() => 's' * 12;

testParamNoType(val) {
  return 10 * val;
}

testParamNoTypeCompare(dynamic val) {
  return 10 * val;
}

//testParam(int req,[int c],{int a= 100,int b=300}){}
//testParam(int req,{int a= 100,int b=300},[int c]){}
testParamPos(int req, [String c = "h", int d]) {}

testParamName(int req, {int c = 8, int d}) {}

testVA() {
  testParamPos(1);
  // 位置参数使用时不能带上参数名
  // The named parameter 'c' isn't defined.
//  testParamPos(2, c:"e");
  // 位置参数不能跳过中间的参数
  // The argument type 'int' can't be assigned to the parameter type 'String'
//  testParamPos(2, 1);
  testParamPos(2, "a");
  testParamPos(3, "b", 4);

  testParamName(1);
  testParamName(2, d: 6);
  // 命名参数必须带上参数名
  // too many positional arugments ...
//  testParamName(2,5,8);
  testParamName(3, c: 7);
  testParamName(4, c: 8, d: 0);
  testParamName(5, d: 9, c: 0);
}

testEmptyReturn() {}

int sum = 0;

countSum(int val) {
  sum += val;
}

testFunction() {
  var list = [32, 123, 43, 31, 55, 346, 786];
  sum = 0;
  list.forEach(countSum);
  print(sum);

  var addFunc = (int a, int b) {
    return a + b;
  };
  var minusFunc = (int a, int b) => a - b;

  print(addFunc(4, 3));
  print(minusFunc(4, 3));
}

testAnonymousFunction() {
  var list = [1, 5, 31, 57, 231, 6, 234, 7];
//  list.forEach({
//    print(it);
//  });
//  list.forEach(
//    print(it);
//  );
  list.forEach((it) => print(it));

  list.forEach((it) {
    print(it);
  });
}

testNestedFunction() {
  int a = 12;
  void myNested() {
    int b = 43;

    void nest() {
      int c = 55;
      // 内层函数能够访问到外层函数的变量
      a = 10;
    }
  }

  // 外层函数访问不到内层函数的变量
  // undefined name 'b'
//  b = 10;
}

testClosureArgument() {
  makeClosure(int a) {
    return (num val) => val + a;
  }

  Function addClosure2 = makeClosure(2);
  Function addClosure3 = makeClosure(3);

  print(addClosure2(5));
  print(addClosure3(5));

  Function minusClosure2;
  Function minusClosure3;

  makeClosure2(int b) {
    b = 2;
    minusClosure2 = (num val) => val - b;
    b = 3;
    minusClosure3 = (num val) => val - b;
  }

  makeClosure2(9);

  print(minusClosure2(5));
  print(minusClosure3(5));

  makeClosure3(int c) {
    Function build(int i) {
      return (num val) => val * i;
    }

    var list = new List(c);
    for (int j = 0; j < c; j++) {
      list[j] = build(j);
    }
    return list;
  }

  var funcList = makeClosure3(5);

  funcList.forEach((func) => print(func(2)));

  makeClosure4(int c) {
    var list = new List(c);
    for (int j = 0; j < c; j++) {
      list[j] = (num val) => val * j;
    }
    return list;
  }

  var funcList2 = makeClosure4(4);

  funcList2.forEach((func) => print(func(3)));

  print("next>>>>>");
  makeClosure5(int c) {
    int len = c;
    var list = new List(c);
    for (int j = 0; j < len; j++) {
      c = j;
      list[j] = (num val) => val * c;
    }
    return list;
  }

  makeClosure5(6).forEach((func) => print(func(4)));
}
