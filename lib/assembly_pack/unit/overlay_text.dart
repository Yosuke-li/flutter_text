import '../../init.dart';
import '../../widget/overlay_field.dart';

class OverlayText extends StatefulWidget {
  const OverlayText({Key? key}) : super(key: key);

  @override
  _OverlayTextState createState() => _OverlayTextState();
}

class _OverlayTextState extends State<OverlayText> {
  String v = '12';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 80.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: OverlayField<String>(
                      initValue: v,
                      lists: const ['zxc', 'scsc'],
                      child: (String value) {
                        return Text(value);
                      },
                      onChange: (String value) {
                        v = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                  Container(
                    height: 100,
                    child: const Text('123'),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PreferredSize(
              child: AppBar(
                title: const Text('overlay text'),
              ),
              preferredSize: const Size.fromHeight(20.0),
            ),
          ),
        ],
      ),
    );
  }
}
