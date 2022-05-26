import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_text/init.dart';

class DesktopPickerPage extends StatefulWidget {
  const DesktopPickerPage({Key? key}) : super(key: key);

  @override
  _DesktopPickerState createState() => _DesktopPickerState();
}

class _DesktopPickerState extends State<DesktopPickerPage> {
  @override
  void initState() {
    super.initState();
  }

  void _singlePicker() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      Log.info(result);
      final PlatformFile _file = result.files.single;
      Log.info(_file);
    }
  }

  void _multiPicker() async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      Log.info(result);
      final PlatformFile _file = result.files.single;
      Log.info(_file);
    }
  }

  void _pickerVideo() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
  }

  // 鼠标右键
  Future<void> _onPointerDown(PointerDownEvent event) async {
    List<PopupMenuItem<int>> menuItems = <PopupMenuItem<int>>[
      PopupMenuItem(child: Text('apply +1'), value: 1),
      PopupMenuItem(child: Text('apply -1'), value: 2),
      PopupMenuItem(child: Text('set to 0'), value: 3),
    ];

    if (event.kind == PointerDeviceKind.mouse &&
        event.buttons == kSecondaryMouseButton) {
      Log.info(event);
      final RenderBox overlay =
          Overlay.of(context)?.context.findRenderObject() as RenderBox;
      final int? menuItem = await showMenu<int>(
          context: context,
          items: menuItems,
          position: RelativeRect.fromSize(
              event.position & const Size(48.0, 48.0), overlay.size));
    }
  }

  //选择custom类型需要带上相应的后缀
  void _pickerCustom() async {
    final FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['epub']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文件选择'),
      ),
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Container(
              margin: EdgeInsets.only(right: screenUtil.adaptive(30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Listener(
                    onPointerDown: (PointerDownEvent event) {
                      _onPointerDown(event);
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        Log.info('111');
                      },
                      child: const Text('右键测试'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _singlePicker();
                    },
                    child: const Text('单选'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _multiPicker();
                    },
                    child: const Text('多选'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _pickerVideo();
                    },
                    child: const Text('选择视频'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _pickerCustom();
                    },
                    child: const Text('选择图书'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
