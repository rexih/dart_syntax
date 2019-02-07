void entrance10() {
  print("enter entrance10");
  testGenericClass();
  print("exit entrance10");
}

void testGenericClass() {
  TestGeneric<MyImplA>(MyImplA(3, 5)).printDataName();
  TestGeneric<MyImplB>(MyImplB(41, 8)).printDataName();
}

class TestGeneric<T extends MyInterface> {
  final T data;

  TestGeneric(this.data);

  void printDataName() {
    print("for ${T}:name=${data.getName()}");
  }

// 泛型S不能实例化
//  S newInstance<S extends String>(String message) {
//    return new S(message);
//  }
}

abstract class MyInterface {
  String getName();
}

class MyImplA implements MyInterface {
  int a;
  int b;

  MyImplA(this.a, this.b);

  @override
  String getName() {
    return (a + b).toString();
  }
}

class MyImplB implements MyInterface {
  int c;
  int d;

  MyImplB(this.c, this.d);

  @override
  String getName() {
    return (c * d).toString();
  }
}
