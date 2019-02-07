entrance05() {
  print("enter entrance05");
  testFor();
  try {
    testAssert();
  } catch (e) {
    print(e);
  }
  print("exit entrance05");
}

void testFor() {
  var list = [4, 5, 2];
  for (var a in list) {
    print(a);
  }
  var callbacks = [];
  for (var j = 0; j < 5; j++) {
    callbacks.add(() => print(j));
  }
  callbacks.forEach((c) => c());

  callbacks.clear();
  print("show error");
  int i = 0;
  for (; i < 9; i++) {
    callbacks.add(() => print(i));
  }
  callbacks.forEach((c) => c());
}

testAssert() {
  assert(2 > 3, "bazinga");
}
