import 'package:file_picker/file_picker.dart';
import 'package:flutter_text/init.dart';

class DesktopPickerPage extends StatefulWidget {
  const DesktopPickerPage({Key key}) : super(key: key);

  @override
  _DesktopPickerState createState() => _DesktopPickerState();
}

class _DesktopPickerState extends State<DesktopPickerPage>  {

  
  @override
  void initState() {
    super.initState();
  }

  void _singlePicker() async {
    final FilePickerResult result = await FilePicker.platform.pickFiles();
    Log.info(result);
    if (result != null) {
      final PlatformFile _file = result.files.single;
      Log.info(_file);
    }
  }

  void _multiPicker() async {
    final FilePickerResult result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    Log.info(result);

    if (result != null) {
      final PlatformFile _file = result.files.single;
      Log.info(_file);
    }
  }

  void _pickerVideo() async {
    final FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    Log.info(result);
  }

  //选择custom类型需要带上相应的后缀
  void _pickerCustom() async {
    final FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['epub']
    );
    Log.info(result);
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
        ));
  }
}
