import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setupTemperatureView()
        
        return true
    }
    
    func setupTemperatureView() {
        
        if let viewController = window?.rootViewController as? ViewController {
            let gateway = TemperatureGatewaySimple()
            let presenter = TemperaturePresenter(view: viewController)
            viewController.input = TemperatureInteractor(gateway: gateway, output: presenter)
        }
        
    }

}

