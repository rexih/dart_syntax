void entrance11() {
  print("enter entrance11");

  var testCallable = TestCallable(3, 9);
  print(testCallable(4,2));

  print("exit entrance11");
}

class TestCallable {
  int a;
  int b;

  TestCallable(this.a, this.b);

  // 声明call方法，将类模拟成函数，使得类表现得像函数
  String call(int c, int d) => "${a + c} and ${b + d}";
}
