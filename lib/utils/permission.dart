import 'package:permission_handler/permission_handler.dart';

class Permission {
  //请求权限
  Future requestPermiss() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([
      PermissionGroup.location,
      PermissionGroup.camera,
      PermissionGroup.storage,
      PermissionGroup.photos,
      PermissionGroup.speech
    ]);
    //校验权限
    if (permissions[PermissionGroup.camera] != PermissionStatus.granted) {
      print("无照相权限");
    }

    if (permissions[PermissionGroup.storage] != PermissionStatus.granted) {
      print("无存储权限");
    }

    if (permissions[PermissionGroup.photos] != PermissionStatus.granted) {
      print("无相册权限");
    }

    if (permissions[PermissionGroup.speech] != PermissionStatus.granted) {
      print("无语音权限");
    }
  }
}
