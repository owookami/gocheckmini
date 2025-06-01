import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // 구글맵 API 키 설정 (실제 사용 시 YOUR_GOOGLE_MAPS_API_KEY를 실제 키로 교체)
    // GMSServices.provideAPIKey("AIzaSyAk5S38hNXK1IGs7wMxGl4vP5genqwCIvY")
    GMSServices.provideAPIKey("AIzaSyD-9tS6M7BhGktBWrCRS33tWMPc_97Y830")
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
