import UIKit
import Firebase
import SwiftUI
import SwiftKeychainWrapper
import IQKeyboardManagerSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    private var appCoordinator: AppCoordinator?
    
    var appWindow: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        
        var appDepedency: AppDependency = AppDependency.makeDefault()
        
        







  //      appDepedency.firestore.loadData()
        
     //   appDepedency.firestore.loadData(completion: () -> Void)
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
        
  //      let welcomeVC = UIHostingController(rootView: WelcomeView())
  //            window.rootViewController?.present(welcomeVC, animated: true, completion: nil)
        self.appWindow = window
        return true
    }
}
