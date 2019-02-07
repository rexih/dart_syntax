entrance08() {
  print("enter entrance08");

  testComputedProperty();
  testAbstract();
  testInterface();
  testOverrideOperator();
  testNoSuchMethod();
  testMixin();
  print("exit entrance08");
}

void testMixin() {
  var testMixin = new TestMixin();
  testMixin.play("hhhahaha ");
}

void testNoSuchMethod() {
  var testNoSuchMethod = TestNoSuchMethod();
  testNoSuchMethod.hello();
  testNoSuchMethod.sayHi();
  var money = testNoSuchMethod.money;
  print(money);
}

void testOverrideOperator() {
  var testOverrideOperator = TestOverrideOperator(1, 4);
  var testOverrideOperator2 = TestOverrideOperator(3, 5);
  var testOverrideOperator3 = testOverrideOperator + testOverrideOperator2;
  print(testOverrideOperator3);
}

void testInterface() {
  var testInterfaceImpl = new TestInterfaceImpl();
}

void testComputedProperty() {
  var testMethod = new TestMethod(1, 2, 3, 4);
  var e2 = testMethod.e;
  var e3 = testMethod.e;
  var e4 = testMethod.e;

  print("e2=${e2};e3=${e3};e4=${e4};");
}

class TestMethod {
  int a;
  int b;
  int c;
  int d;

  TestMethod(this.a, this.b, this.c, this.d);

  int get e {
    // 计算属性在执行getter方法时每次都会执行statement，与Vue的计算属性不同
    print("get e");
    int ret = a + b;
    return ret;
  }

  // 显式定义setter时避免设置返回类型
  // avoid return type on setters
  /*void*/
  set e(int vi) {
    a = vi - b;
  }
}

void testAbstract() {
  var testAbstractImpl = TestAbstractImpl();

  // 抽象类不能用new 实例化
  //abstract class can't be created with a 'new' expression
//  var tmp = TestAbstract();
}

abstract class TestAbstract {
  void methodA() => print("real method");

  void abstractMethod(String text);

  int a;

  int get abstractGet;

  set abstractSet(int value);
}

class TestAbstractImpl extends TestAbstract {
  @override
  // TODO: implement abstractGet
  int get abstractGet => null;

  @override
  void abstractMethod(String text) {
    // TODO: implement abstractMethod
  }

  @override
  void set abstractSet(int value) {
    // TODO: implement abstractSet
  }

//  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class TestInterface {
  void saySth(String text) {
    print(text);
  }
}

class TestInterfaceImpl implements TestInterface {
  @override
  void saySth(String text) {
    // TODO: implement saySth
  }
}

class TestOverrideOperator {
  int a;
  int b;

  TestOverrideOperator(this.a, this.b);

  TestOverrideOperator operator +(TestOverrideOperator opVal) =>
      TestOverrideOperator(this.a + opVal.a, this.b + opVal.b);

  @override
  String toString() {
    return 'TestOverrideOperator{a: $a, b: $b}';
  }
}

class Foo {
  void sayHi() => print("hi");

  int get money => 123;
}

class TestNoSuchMethod implements Foo {
  void hello() => print("hello");

  int get salary => 777;

  @override
  noSuchMethod(Invocation invocation) {
    var runtimeType = invocation.runtimeType;
    // invocation.memberName 返回的是Symbol对象，
    // #操作符 用于引用一个操作符（方法名）
    if (invocation.memberName == #sayHi) {
      if (invocation.isMethod) {
        return hello();
      }
    } else if (invocation.memberName == #money) {
      if (invocation.isGetter) {
        // 如果调用的是get/set方法，应当返回一个get/set方法的返回值
//        return hello;
        return salary;
      }
    }
    return super.noSuchMethod(invocation);
  }
}

class TestMixin extends Parent with MixinA {
  String b;
}

class Parent {
  int a;
}

class MixinA {
  int c;

//  MixinA(this.c);

  void play(String text) {
    print(text);
//    super.toString();
  }
}
