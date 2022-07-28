import UIKit
import Flutter
import GoogleMaps
<<<<<<< HEAD
import FirebaseCore
=======
import Firebase

>>>>>>> forgotpage
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
<<<<<<< HEAD
=======
    FirebaseApp.configure()
>>>>>>> forgotpage
    GMSServices.provideAPIKey("AIzaSyAJxz4yLqqnj_Dq-GVBINpjqeO5G8ksOoI")
    GeneratedPluginRegistrant.register(with: self)
    FirebaseApp.configure()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}