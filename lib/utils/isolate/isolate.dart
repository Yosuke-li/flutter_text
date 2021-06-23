import 'dart:isolate';

///isolate是dart的线程 通过isolate可以实现dart的多线程
///每个isolate都有自己的事件循环
///isolate在flutter并不共享内存，不同isolate通过消息进行通信


///另外一个可以帮助你决定使用 Future 或 Isolate 的因素是运行某些代码所需要的平均时间。
//
// 如果一个方法需要几毫秒 => Future
// 如果一个处理流程需要几百毫秒 => Isolate
//
// 以下是一些很好的 Isolate 选项：
//
// JSON 解码：解码 JSON（HttpRequest 的响应）可能需要一些时间 => 使用 compute
// 加密：加密可能非常耗时 => Isolate
// 图像处理：处理图像（比如：剪裁）确实需要一些时间来完成 => Isolate
// 从 Web 加载图像：该场景下，为什么不将它委托给一个完全加载后返回完整图像的 Isolate？
//
///

Future<String> load() async {
  final ReceivePort receivePort = ReceivePort(); //创建管道
  await Isolate.spawn(messageIso, receivePort.sendPort);
  await for (dynamic msg in receivePort) {
    if (msg is SendPort) {
      final SendPort sendPort = msg;
      sendPort.send('isolate with number ');
      print('isolate with msg');
    } else {
      print('ReceivePort get msg is $msg');
      receivePort.close();
      return msg;
    }
  }
  return null;
}

void messageIso(SendPort sendPort) async {
  final ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort); //取请求数据
  final String url = await receivePort.first;
  receivePort.close();

  sendPort.send(url + '12312313');
  print('取请求数据');
}