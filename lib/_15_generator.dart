void entrance15() {
  print("enter entrance15");
  testSyncForEach();
  testYieldForEach();
  testStream();
  testStreamApi();
  print("exit entrance15");
}

void testSyncForEach() {
  var iterable = naturalTo(10);
  Iterator<int> itor = iterable.iterator;
  while (itor.moveNext()) {
    print(itor.current);
  }

  // 以上代码可以简写为
  var iter2 = naturalTo(5);
  for (var value in iter2) {
    print(value);
  }
}

Iterable<int> naturalTo(int n) sync* {
  int i = 1;
  while (i <= n) {
    yield i++;
  }
}

Iterable<int> naturalDownFrom(int n) sync* {
  if (n == 1) {
    yield 1;
  } else {
    yield n;
    yield* naturalDownFrom(n - 1);
  }
}

void testYieldForEach() {
  var itor = naturalDownFrom(10);
  for (var value in itor) {
    print("naturalDownFrom:${value}");
  }
}

Stream<int> countStream(int n) async* {
  int i = 1;
  while (i <= n) {
    yield i++;
  }
}

Future<int> receiveStream(Stream<int> stream) async {
  var sum = 0;
  await for (var value in stream) {
    sum += value;
  }
  return sum;
}

void testStream() async {
  var stream = countStream(8);
  var sum = await receiveStream(stream);
  print("stream sum=${sum}");
}

sumElemAbove5(Stream<int> stream) async {
  var sum = 0;
  await for (var cur in stream.where((value) => value > 5)) {
    print("sumElemAbove5 cur:${cur}");
    sum += cur;

  }
  return sum;
}

void testStreamApi() async {
  var stream = countStream(13);
  var sum = await sumElemAbove5(stream);
  print("sumElemAbove5 sum=${sum}");
}