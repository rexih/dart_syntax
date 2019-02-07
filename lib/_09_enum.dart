void entrance09() {
  print("enter entrance09");

  // 获取所有的枚举值
  var values = TestEum.values;
  // 枚举的values下标从0开始
  var index2 = TestEum.TypeTwo.index;
  print("values:${values};index2:${index2}");

  var type = TestEum.TypeThree;

  // enum 使用switch必须把所有枚举都列出，否则报错
  switch (type) {
    case TestEum.TypeOne:
      break;
    case TestEum.TypeTwo:
      break;
    case TestEum.TypeThree:
      break;
  }

  print("exit entrance09");
}

enum TestEum { TypeOne, TypeTwo, TypeThree }
