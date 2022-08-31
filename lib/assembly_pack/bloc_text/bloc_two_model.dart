import 'package:flutter_text/assembly_pack/event_bus/event_util.dart';
import 'package:self_utils/widget/bloc/bloc_widget.dart';

class BlocTwoModel implements BlocBase {
  static late int _count;

  final StreamController<int> _controller = StreamController<int>();
  StreamSink<int> get _inAdd => _controller.sink;
  Stream<int> get outCount => _controller.stream;

  final StreamController _action = StreamController();
  StreamSink get actionStream => _action.sink;

  //构造函数
  BlocTwoModel() {
    _count = 0;
    _action.stream.listen(_handleVoid);
  }

  void _handleVoid(data) {
    _count = data +1;
    _inAdd.add(_count);
  }

  @override
  void dispose() {
    _controller.close();
    _action.close();
  }
}