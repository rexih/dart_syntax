entrance04() {
  print("enter entrance04");
  testType();
  testNull();
  testCascade();
  print("exit entrance04");
}

testType() {
  print("ad" is String);
  print(1 is! String);

  Object child = Child(10);

  if (child is Child) {
    // is 检查命中后，实例可以直接使用真实类型的成员
    var b = child.b;
  }

  // 没有使用is检查前，可以使用as强转指定类型，
  // 但是如果为null或者类型不符则抛出异常
  var b2 = (child as Child).b;
}

class Parent {
  int a;
}

class Child extends Parent {
  int b;

  Child(this.b);
}

testNull() {
  var child;

  print(child?.b);

  var aChild = child ?? Child(15);

  print(aChild.b);

  child ??= Child(12);
  print(child.b);
}

testCascade() {
  var user = User()
    ..age = 10
    ..name = "rexih"
    ..id = 1021
    ..setAlias("Lisa")
    ..sex = 1;
  print(user);

  // 类的静态方法，不论是正常调用还是级联运算，都不能通过实例对象调用
  // Static method 'setNice' can't be accessed through an instance
//  user.setNice(false);
//  user..setNice(false);

  StringBuffer sb = new StringBuffer();
  sb.write("aa");
  sb..write("a")..write("b");
  print(sb.toString());

  // 级联操作只能从实例对象或者一个返回实例对象的方法开始，
  // 后续操作都是起始对象可以调用的成员方法
  // 级联操作相当于调用了成员方法后，又返回了实例对象交由下一个方法使用
  // The expression here has a type of 'void', and therefor cannot be used
//  sb.write("v")
//  ..write("c");

  var name = User().findName();
  // 级联操作可以从实例变量开始
  var s = name..substring(2);
  // s的值没有变，因为级联操作只是为了处理被操作的对象，
  // 赋值给另一个变量的不是方法的返回值，而是级联起始的对象
  print(s);
  String findName = User().findName()
    ..substring(1)
    ..toUpperCase();
  print(findName);
}

class User {
  int id;
  String name = "anonymous";
  int sex;
  int age;
  static bool nice;

  void setAlias(String alias) {
    name = alias;
  }

  static void setNice(bool isNice) {
    nice = isNice;
  }

  String findName() => name;

  @override
  String toString() {
    return 'User{id: $id, name: $name, sex: $sex, age: $age}';
  }
}
