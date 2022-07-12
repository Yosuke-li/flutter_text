import Flutter
import UIKit

public class SwiftFlutterHeepayPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_heepay", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterHeepayPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if (call.method == "init") {
          let name = call.arguments as! String;
          result("ios init " + name);
      } else if (call.method == "getPlatformVersion") {
          result("iOS " + UIDevice.current.systemVersion);
      }
  }
}
