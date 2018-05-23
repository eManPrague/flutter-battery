import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    GeneratedPluginRegistrant.register(with: self);

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
    let batteryChannel = FlutterMethodChannel.init(name: "battery", binaryMessenger: controller);
    batteryChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: FlutterResult) -> Void in
        if (call.method == "getBatteryLevel") {
          let batteryLevel : Int = self.getBatteryLevel();
          if(batteryLevel != -1) {
            result(batteryLevel);
          } else {
            result(FlutterError.init(code: "UNAVAILABLE", message: "Battery info unavailable", details: nil));
          }
        } else {
            result(FlutterMethodNotImplemented);
        }
    });

    return super.application(application, didFinishLaunchingWithOptions: launchOptions);
  }

  private func getBatteryLevel() -> Int {
    let device = UIDevice.current;
    device.isBatteryMonitoringEnabled = true;
    if (device.batteryState == UIDeviceBatteryState.unknown) {
        return -1;
    } else {
        return Int(device.batteryLevel * 100);
    }
  }
}
