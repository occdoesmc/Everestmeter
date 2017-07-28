import UIKit

@UIApplicationMain final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
}

extension AppDelegate {
    func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil
        ) -> Bool {
        altitudeViewController.startMeasuring()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        altitudeViewController.stopMeasuring()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        altitudeViewController.startMeasuring()
    }
}

private extension AppDelegate {
    var altitudeViewController: AltitudeViewController {
        guard let controller =  window?.rootViewController as? AltitudeViewController else {
            fatalError("Invalid root view controller")
        }
        return controller
    }
}
