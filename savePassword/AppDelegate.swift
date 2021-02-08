import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: AppCoordinator?
    private var appDepedency: AppDependency = AppDependency.makeDefault()
    
    var appWindow: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        appDepedency.cryptService.createKey()
                
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator = AppCoordinator(window: window, appDepedency: appDepedency)
        self.appCoordinator?.begin()
        self.appWindow = window
        return true
    }
}

@available(iOS 13.0, *)
    private func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.normal.iconColor = .lightGray
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        
        itemAppearance.selected.iconColor = .white
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
