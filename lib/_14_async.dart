
void entrance14() {
  print("enter entrance14");

  testAwait();
  testAsyncDetail();
  print("exit entrance14");
}


void testAwait() async {
  print("testFuture enter");
  String message = await getMessage("hello rex");
  print(message);
  print("testFuture end");

}

Future<String> getMessage(String msg){
  return new Future<String>.delayed(Duration(seconds: 2),(){
    return msg;
  });
}

void testAsyncDetail() {
  var f = test();
  print("executed:${f}");
}

Future test() async {
  // 第一个await，执行完getSum中的同步代码后，等待异步结果，test临时返回，invoker继续执行
  var sum = await getSum();
  // await异步结果返回后，test继续执行
  print("sum is ${sum}");
  var multi = await getMulti();
  print("multi is ${multi}");
}

int getSum() {
  int sum = 0;
  for (int i = 0; i < 10; i++) {
    print("current:${i}");
    sum += i;
  }
  return sum;
}

int getMulti(){
  int multi = 0;
  for (int i = 0; i < 10; i++) {
    print("current:${i}");
    multi *= i;
  }
  return multi;
}
