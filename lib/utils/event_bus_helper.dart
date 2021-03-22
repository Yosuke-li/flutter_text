import 'dart:async';

//eventBus封装
class EventBusHelper {
  //ignore:close_sinks
  static final StreamController asyncStreamController =
  _GetAsyncStreamController.getInstance();

  static StreamSubscription listen<T>(void onData(T event),
      {Function onError, void onDone(), bool cancelOnError}) {
    return asyncStreamController.stream.listen((Object event) {
      if (event is T) {
        onData(event);
      }
    }, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}

class _GetAsyncStreamController {
  _GetAsyncStreamController._();

  //ignore:close_sinks
  static StreamController _asyncStreamController;

  static StreamController getInstance() {
    if (_asyncStreamController == null) {
      _asyncStreamController = StreamController.broadcast();
    }
    return _asyncStreamController;
  }
}
