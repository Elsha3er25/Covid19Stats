import UIKit
import Flutter

// The @UIApplicationMain attribute identifies this class as the entry point for the app.
// It also automatically creates an instance of this class when the app launches.
@UIApplicationMain
// This class is a subclass of FlutterAppDelegate, which is a custom class provided by the Flutter framework.
// It is responsible for setting up the Flutter engine and integrating it with the native iOS app.
@objc class AppDelegate: FlutterAppDelegate {
  
  // This method is called when the app has finished launching.
  // It is responsible for registering any plugins that the Flutter code might use.
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Register any generated plugins with the Flutter engine.
    GeneratedPluginRegistrant.register(with: self)

