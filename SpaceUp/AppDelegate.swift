import SpriteKit
import StoreKit
import AVFoundation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  //let paymentTransactionObserver = PaymentTransactionObserver()

  var window: UIWindow?
  var viewController: UIViewController?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    /*let audioSession = AVAudioSession.sharedInstance()

    do {
      try audioSession.setCategory(AVAudioSessionCategoryAmbient)
    } catch _ {
    }*/
    
    // Payment transaction
    //let queue = SKPaymentQueue.defaultQueue()
    //queue.addTransactionObserver(paymentTransactionObserver)

    return true
  }

  func applicationWillResignActive(application: UIApplication) {
  }

  func applicationDidEnterBackground(application: UIApplication) {
  }

  func applicationWillEnterForeground(application: UIApplication) {
  }

  func applicationDidBecomeActive(application: UIApplication) {
  }

  func applicationWillTerminate(application: UIApplication) {
  }
}

