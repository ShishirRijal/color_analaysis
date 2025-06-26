import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let deviceInfoChannel = FlutterMethodChannel(
      name: "com.np.shishirrijal/device_info",
      binaryMessenger: controller.binaryMessenger)
    deviceInfoChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "getDeviceInfo" {
        let device = UIDevice.current
        let info: [String: Any] = [
          "platform": "iOS",
          "model": device.model,
          "osVersion": "\(device.systemName) \(device.systemVersion)",
        ]
        result(info)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
