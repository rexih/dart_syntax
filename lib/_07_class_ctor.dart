entrance07() {
  print("enter entrance07");
  testDefaultCtor();
  testNotNamedCtor();
  testNonDefaultSuperClass();
  testInitializer();
  testFactory();
  print("exit entrance07");
}

void testDefaultCtor() {
  // 只要有构造函数，即使是命名构造函数，就不会提供默认的构造函数
  // The class 'TestDefault' doesn't have a default constructor
//  var testDefault = TestDefault();
  var testDefault = TestDefault.namedCtor(10);
}

class TestDefault {
  int a;
  int b;

//  TestDefault();
  TestDefault.namedCtor(int c) {
    a = c;
    b = c;
  }
}

void testNotNamedCtor() {
  // 未命名构造函数只能有一个，需要处理好其参数列表，考虑如何设置可选参数
  var testNotNamed = TestNotNamed(10, 12);
}

class TestNotNamed {
  int c;
  int d;
  int e;
  int f;

//  TestNotNamed();
//  TestNotNamed(this.d);
//  TestNotNamed(this.c, {this.d, this.e, this.f});
//  TestNotNamed(this.c, [this.d, this.e, this.f]);

  TestNotNamed(int x, int y) {
    c = x + y;
  }
}

void testNonDefaultSuperClass() {
  var testChild = TestChild.noArg();
}

class TestParent {
  int m;

  TestParent.noArg();
}

class TestChild extends TestParent {
  int x;

  // 不显示定义构造函数则报错
//  TestChild() :super.noArg();
  TestChild.noArg() : super.noArg();
}

void testNamedCtorAndRedirectCtor() {
  var rectangle1 = Rectangle.height10(51, 3);
  var rectangle2 = Rectangle.twiceWidth(82, 5);
}

class Rectangle {
  int id;
  int width;
  int height;

  Rectangle(this.id, {this.width, this.height});

  // 命名构造函数
  Rectangle.width10(this.id, this.height) {
    width = 10;
  }

  Rectangle.height10(this.id, this.width) {
    height = 10;
  }

  Rectangle.twiceWidth(int id, int width)
      // 构造函数重定向
      // 初始化器不能使用this，也就是只能使用顶层函数和static静态函数
      : this(id, width: width, height: getTwiceWidth(width));
}

int getTwiceWidth(int width) => width * 2;

void testInitializer() {
  var square = Square.testInitList(11);
}

class Square extends Rectangle {
  String desc;
  String comment;

  Square(int id, int width, int height)
      : super(id, width: width, height: height);

  Square.bySize(int id, int size) : super(id, width: size, height: size);

  Square.width10(int id) : this.bySize(id, 10);

  Square.testInitList(int id)
      : desc = "it's a desc",
        // 重定向构造函数初始化器必须单独使用，不能和域初始化器和父类构造函数初始化器同时使用
        // The redirecting constructor can't have a field initializer
//        this.bySize(id,10),
        super(id)
  // 父类构造函数初始化器必须是初始化器列表的最后一项
  // super call must be last in initializer list
//      ,comment = "a new comment"
  ;

  Square.initMember()
      :comment="a comment",
        super(1);
}

void testFactory() {
  TestFactory._internal("test");
}

class TestFactory {
  final String factoryName;

  static final Map<String, TestFactory> _cache = <String, TestFactory>{};

  TestFactory._internal(this.factoryName);

  // factory 声明的工厂构造函数不能使用this关键字，这种构造函数类似static静态函数
  // Initializing formal parameters can't be used in factory constructors.
//  factory TestFactory(this.factoryName);

  factory TestFactory(String factoryName) {
    var instance = _cache[factoryName];
    if (null == instance) {
      instance = TestFactory._internal(factoryName);
      _cache[factoryName] = instance;
      return instance;
    } else {
      return instance;
    }
  }

}
