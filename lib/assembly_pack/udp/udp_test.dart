import '../../init.dart';

InternetAddress _internetAddress = InternetAddress('172.30.75.26');

bool _hasMatch(String? value, String pattern) {
  return (value == null) ? false :RegExp(pattern).hasMatch(value);
}

extension IpString on String {

}

class UdpTestPage extends StatefulWidget {
  const UdpTestPage({Key? key}) : super(key: key);

  @override
  State<UdpTestPage> createState() => _UdpTestPageState();
}

class _UdpTestPageState extends State<UdpTestPage> {
  late RawDatagramSocket _bind;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    _bind = await RawDatagramSocket.bind(_internetAddress, 4566);
    Log.info(_bind);
    _bind.broadcastEnabled = true;
    _bind.readEventsEnabled = true;
    _bind.listen((event) {
      Log.info('$event');
    }, onError: () {
      Log.info('onError');
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('udp'),
      ),
      body: Container(),
    );
  }
}
