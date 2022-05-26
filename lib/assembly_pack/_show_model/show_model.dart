import 'package:flutter/material.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:flutter_text/utils/screen.dart';
import 'package:flutter_text/widget/modal_utils.dart';

class ModalText {
  static Future<void> model(BuildContext context,
      {String? title, void Function()? onFunc}) async {
    await ModalUtils.showModal(
      context,
      modalBackgroundColor: const Color(0x00999999),
      dynamicBottom: Container(
        alignment: Alignment.center,
        child: Container(
          width: screenUtil.adaptive(820),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(screenUtil.adaptive(30))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: screenUtil.adaptive(60),
                ),
                alignment: Alignment.center,
                child: const Text(
                  '提示',
                  style: TextStyle(color: Color(0xff404040), fontSize: 52),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  top: screenUtil.adaptive(80),
                  bottom: screenUtil.adaptive(90),
                  left: screenUtil.adaptive(73),
                ),
                child: Text(
                  '${title ?? '删除本条数据？'}',
                  style: const TextStyle(
                    fontSize: 47,
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
                            width: screenUtil.adaptive(360),
                            height: screenUtil.adaptive(110),
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
                                fontSize: 45,
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
                            width: screenUtil.adaptive(360),
                            height: screenUtil.adaptive(110),
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
                                fontSize: 45,
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
