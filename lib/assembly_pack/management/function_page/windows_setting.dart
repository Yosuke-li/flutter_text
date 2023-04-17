import 'package:self_utils/init.dart';

import '../../../init.dart';

class WindowsSettingPage extends StatefulWidget {
  const WindowsSettingPage({Key? key}) : super(key: key);

  @override
  State<WindowsSettingPage> createState() => _WindowsSettingPageState();
}

class _WindowsSettingPageState extends State<WindowsSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 30, left: 30),
                  child: Text('${S.of(context).langSetting}'),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 80,
                    child: const ChooseLangPage(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 30, left: 30),
                  child: const Text('主题模式'),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 100,
                    child: _chooseSunNight(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 30, left: 30),
                  child: const Text('清理数据'),
                ),
                ElevatedButton(
                  onPressed: () {
                    SettingToast.tipToast(context, onFunc: () {
                      LocateStorage.clean();
                    });
                  },
                  child: const Text('点击清理数据'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _chooseSunNight() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              CircleCheckBox(
                size: 15,
                isChecked: GlobalStore.theme == 'light',
                checkedWidget: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12,
                ),
                animationDuration: const Duration(milliseconds: 100),
                onTap: (val) {
                  GlobalStore.theme = 'light';
                  EventBusHelper.asyncStreamController?.add(EventBusM()..theme = 'light');
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              CircleCheckBox(
                size: 15,
                isChecked: GlobalStore.theme == 'dark',
                checkedWidget: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12,
                ),
                animationDuration: const Duration(milliseconds: 100),
                onTap: (val) {
                  GlobalStore.theme = 'dark';
                  EventBusHelper.asyncStreamController?.add(EventBusM()..theme = 'dark');
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SettingToast {
  static Future<void> tipToast(BuildContext context,
      {String? title, void Function()? onFunc}) async {
    await ModalUtils.showModal(
      context,
      modalBackgroundColor: const Color(0xffffffff),
      modalSize: ModalSize(width: 300),
      dynamicBottom: Container(
        alignment: Alignment.center,
        child: Container(
          width: 300,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(screenUtil.adaptive(30))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: const Text(
                  '提示',
                  style: TextStyle(color: Color(0xff404040)),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 30,
                  left: 30,
                ),
                child: Text(
                  '${title ?? '是否清理所有数据？'}',
                  style: const TextStyle(
                    color: Color(0xff426ba5),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    bottom: screenUtil.adaptive(30),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: InkWell(
                          onTap: () {
                            NavigatorUtils.pop(context);
                          },
                          borderRadius:
                              BorderRadius.circular(screenUtil.adaptive(20)),
                          child: Container(
                            width: 90,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color(0xb3eeeeee),
                              borderRadius: BorderRadius.circular(
                                  screenUtil.adaptive(20)),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              '取消',
                              style: TextStyle(
                                color: Color(0xff878787),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            NavigatorUtils.pop(context);
                            onFunc?.call();
                          },
                          borderRadius:
                              BorderRadius.circular(screenUtil.adaptive(20)),
                          child: Container(
                            width: 90,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color(0xff577fba),
                              borderRadius: BorderRadius.circular(
                                  screenUtil.adaptive(20)),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              '确定',
                              style: TextStyle(
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
