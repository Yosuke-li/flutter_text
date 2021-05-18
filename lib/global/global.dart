class GlobalStore {
  static bool isShowOverlay = false; //flutter自带的性能监听 控制
  static String homeIp = '192.168.1.101';
  static String companyIp = '172.31.172.65'; //todo ipconfig 因为非公司内网所以无法使用
  static bool isUserFiddle = true; //是否使用fiddle
}

class EventCache {
  bool isRoute;
}
