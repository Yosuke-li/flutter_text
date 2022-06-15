import 'package:shell/shell.dart';

import '../init.dart';

class ShellTest extends StatefulWidget {
  const ShellTest({Key? key}) : super(key: key);

  @override
  State<ShellTest> createState() => _ShellTestState();
}

class _ShellTestState extends State<ShellTest> {
  final Shell shell = Shell();

  void _run() async {
    await shell.start('find', arguments: ['/Users/lixuan/Documents/work']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('shell 测试'),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {
              _run();
            }, child: const Text('shell run'))
          ],
        ),
      ),
    );
  }
}
