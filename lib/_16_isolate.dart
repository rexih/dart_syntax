import 'dart:isolate';

void entrance16() {
  print("enter entrance16");
  loadData();
  print("exit entrance16");
}

loadData() async {
  // 1. 创建主线程接收通讯消息的接收端口
  ReceivePort mainIsolateReceivePort = new ReceivePort();
  // 2. 创建子线程的进入点函数void entryPoint(T message)，并传递入参（此处为主线程通讯用的发送端口）
  await Isolate.spawn(asyncRunnable, mainIsolateReceivePort.sendPort);

  // 5. 通过stream.first获取子线程发送过来的第一条信息，此处为子线程的发送端口
  SendPort sendPort = await mainIsolateReceivePort.first;

  // 6. 必须要新建一个主线程接收通讯消息的接收端口，因为单播stream调用first以后，就会关闭
  ReceivePort response = new ReceivePort();
  // 7. 向子线程发送数据
  sendPort
      .send(["https://jsonplaceholder.typicode.com/posts", response.sendPort]);

  // 10. 通过stream.first获取子线程发送过来的第一条信息，此处为消息集合
  var resp = await response.first;
  print("main isolate recv:");
  resp.forEach(print);
}

asyncRunnable(SendPort sendPort) async {
  // 3. 创建子线程接收通讯消息的接收端口
  ReceivePort asyncIsolateReceivePort = new ReceivePort();

  // 4. 使用主线程的发送端口发送一条数据，此处为子线程的发送端口
  sendPort.send(asyncIsolateReceivePort.sendPort);

  // 8. 从接收端口获取stream流的迭代数据
  await for (var msg in asyncIsolateReceivePort) {
    String data = msg[0];
    print("async isolate recv: ${data}");
    SendPort replyTo = msg[1];

    await Future.delayed(Duration(seconds: 2));
    // 9. 向主线程发送消息数据
    replyTo.send([
      "first line",
      "second line",
      "third line",
      "fourth line",
      "fifth line",
      "sixth line"
    ]);
  }
}
