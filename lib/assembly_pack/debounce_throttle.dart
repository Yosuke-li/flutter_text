import 'package:flutter_text/init.dart';

class DebounceTPage extends StatefulWidget {
  @override
  _DebounceTState createState() => _DebounceTState();
}

class _DebounceTState extends State<DebounceTPage> {
  int normal = 0;
  int debounce = 0;
  int throttle = 0;

  Timer? _timer;
  bool canAction = true;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('防抖和节流'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    normal++;
                  });
                },
                child: Text('$normal'),
              ),
              //todo 防抖
              InkWell(
                onTap: () {
                  setState(() {
                    _timer?.cancel();
                    _timer = Timer(const Duration(milliseconds: 2000), () {
                      setState(() {
                        debounce++;
                      });
                    });
                  });
                },
                child: Text('$debounce'),
              ),
              //todo 节流
              InkWell(
                onTap: () async {
                  if (!canAction) return;
                  setState(() {
                    canAction = false;
                  });
                  await Future<void>.delayed(const Duration(milliseconds: 2000));
                  throttle++;
                  canAction = true;
                  setState(() {});
                },
                child: Text('$throttle'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
