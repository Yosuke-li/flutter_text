import 'package:flutter/material.dart';
import 'package:self_utils/utils/navigator.dart';
import 'package:self_utils/utils/screen.dart';
import 'package:self_utils/widget/modal_utils.dart';

class ModalText {
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
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 30,
                  left: 30,
                ),
                child: Text(
                  '${title ?? '删除本条数据？'}',
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
