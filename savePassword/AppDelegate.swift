import UIKit
import Firebase
import SwiftUI
import SwiftKeychainWrapper


@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    private var appCoordinator: AppCoordinator?
    
    var appWindow: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        FirebaseApp.configure()
        
        var appDepedency: AppDependency = AppDependency.makeDefault()
        appDepedency.firestore.loadData()
        print(Common.listOfLoginAndPassword)

        let window = UIWindow(frame: UIScreen.main.bounds)
        
    //    KeychainWrapper.standard.removeObject(forKey: "uid")
        
        
        self.appCoordinator = AppCoordinator(window: window, appDepedency: appDepedency)
        self.appCoordinator?.begin()
        
        if KeychainWrapper.standard.string(forKey: "uid") == nil{
            appDepedency.cryptService.createKey()
            Common.listOfLoginAndPassword = []
            let vc = UIHostingController(rootView: ContentView())
            NotificationCenter.default.addObserver(forName: NSNotification.Name("dismissSwiftUI"), object: nil, queue: nil) { (_) in
                vc.dismiss(animated: true, completion: nil)
                    let listNavigationControllers = (window.rootViewController as! UITabBarController).viewControllers?[0] as! UINavigationController
                    let vc = listNavigationControllers.viewControllers[0] as! ListViewController
                    vc.presenter.updateList()
            }
            vc.modalPresentationStyle = .fullScreen
            window.rootViewController?.present(vc, animated: false, completion: nil)
        }
        else {
            let listNavigationControllers = (window.rootViewController as! UITabBarController).viewControllers?[0] as! UINavigationController
            let vc = listNavigationControllers.viewControllers[0] as! ListViewController
            DispatchQueue.global().async {
                vc.presenter.updateList()
            }
        }

        self.appWindow = window
        return true
    }
}
