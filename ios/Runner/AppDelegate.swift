import UIKit
import Flutter
import YPImagePicker
import AVFoundation
import AVKit
import Photos

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var navigationController: UINavigationController!
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      let controller = window?.rootViewController as! FlutterViewController
      self.navigationController = UINavigationController(rootViewController: controller)
      self.window.rootViewController = self.navigationController
      self.navigationController.setNavigationBarHidden(true, animated: false)
      self.window.makeKeyAndVisible()
      let methodChannel = FlutterMethodChannel(name: "test", binaryMessenger:controller.binaryMessenger)
      
      methodChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
              
        if call.method == "test" {
            func resolutionForLocalVideo(url: URL) -> CGSize? {
                guard let track = AVURLAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return nil }
                let size = track.naturalSize.applying(track.preferredTransform)
                return CGSize(width: abs(size.width), height: abs(size.height))
            }
            func showPicker() {
                var config = YPImagePickerConfiguration()
                let picker = YPImagePicker(configuration: config)
                picker.didFinishPicking { [weak picker] items, cancelled in

                    if cancelled {
                        print("Picker was canceled")
                        picker?.dismiss(animated: true, completion: nil)
                        return
                    }
                    _ = items.map { print("🧀 \($0)") }
                
                    if let firstItem = items.first {
                        switch firstItem {
                        case .photo(let photo):
                            picker?.dismiss(animated: true, completion: nil)
                        case .video(let video):
                            let assetURL = video.url
                            let playerVC = AVPlayerViewController()
                            let player = AVPlayer(playerItem: AVPlayerItem(url:assetURL))
                            playerVC.player = player

                            picker?.dismiss(animated: true, completion: { [weak self] in
                            print("😀 \(String(describing: resolutionForLocalVideo(url: assetURL)!))")
                            })
                        }
                    }
                }

                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.navigationController?.present(picker, animated: true, completion: nil)
            }
            showPicker()
        } else {
          result(FlutterMethodNotImplemented)
          return
        }
      })
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
