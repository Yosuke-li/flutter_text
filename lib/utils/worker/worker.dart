import 'dart:async';

import '../event_bus_helper.dart';

typedef CallBack<T> = Function(T callback);

class Worker {
  Worker({this.worker});

  final Future<void> Function() worker;

  bool _dispose = false;

  void dispose() {
    if (_dispose == true) {
      return;
    }
    _dispose = true;
    worker();
  }

  void call() => dispose();
}

//防抖方法
Worker antiShake<T>(
    IWorker<T> value,
  CallBack<T> callBack, {
  Duration time,
  Function onError,
  void Function() onDone,
  bool cancelOnError,
}) {
  final Bouncer _bouncer = Bouncer(delay: time ?? const Duration(seconds: 1));
  final StreamSubscription _stream = value.listen(
    (T event) {
      _bouncer.call(() => callBack(event));
    },
  );
  return Worker(worker: _stream.cancel);
}

abstract class IWorker<T> {
  static IWorker p;

  StreamSubscription<T> listen(void onData(T event),
      {Function onError, void onDone(), bool cancelOnError});
}

//轮询器
class Bouncer {
  final Duration delay;
  Timer _timer;

  Bouncer({this.delay});

  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() => _timer?.cancel();
}
