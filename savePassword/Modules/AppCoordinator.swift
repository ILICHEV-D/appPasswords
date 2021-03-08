import Foundation
import UIKit
import Firebase
import SwiftUI


class AppCoordinator{
    
    private let window: UIWindow
    private let appDepedency: AppDependency
    private lazy var tabBarController = UITabBarController()
    private var navigationControllers: [UINavigationController] = []
    
    init(window: UIWindow, appDepedency: AppDependency) {
        self.window = window
        self.appDepedency = appDepedency
    }
    
    func begin(){
        Common.getAllIcons()
        
        setupList()
        setupAdd()
        setupSetting()
        
        self.tabBarController.setViewControllers(navigationControllers, animated: false)
        self.window.rootViewController = self.tabBarController
        self.window.makeKeyAndVisible()
    }
    
}

private extension AppCoordinator {
    func setupList() {
        let listPresenter = ListPresenter()
        let listVC = ListViewController(presenter: listPresenter, appDepedency: appDepedency)
        let listNC = UINavigationController(rootViewController: listVC)
        
        listVC.navigationItem.title = NSLocalizedString(Localization.TabBar.password, comment: "")
        
        listVC.tabBarItem =
            UITabBarItem(
                title: NSLocalizedString(Localization.TabBar.password, comment: ""),
                image: UIImage(systemName: "magnifyingglass"),
                tag: 0)
        
        navigationControllers.append(listNC)

//        "choice1" = "first";
//        "choice2" = "second";
//        "choice3"  = "third";
//
//        "choice1" = "первый";
//        "choice2" = "второй";
//        "choice3"  = "третий";

    }
    
    func setupAdd() {
        let newPasswordPresenter = NewPasswordPresenter()
        let newPasswordVC = NewPasswordViewController(presenter: newPasswordPresenter, appDepedency: appDepedency)
        let newPasswordNC = UINavigationController(rootViewController: newPasswordVC)
                
        newPasswordVC.navigationItem.title = NSLocalizedString(Localization.TabBar.add, comment: "")
        
        newPasswordVC.tabBarItem =
            UITabBarItem(
                title: NSLocalizedString(Localization.TabBar.add, comment: ""),
                image: UIImage(systemName: "plus.circle"),
                tag: 1)
        navigationControllers.append(newPasswordNC)
    }
    
    func setupSetting() {
        let settingPresenter = SettingPresenter()
        let settingVC = SettingViewController(presenter: settingPresenter, appDepedency: appDepedency)
        let settingNC = UINavigationController(rootViewController: settingVC)
        

        settingVC.navigationItem.title = NSLocalizedString(Localization.TabBar.setting, comment: "")
        
        settingVC.tabBarItem =
            UITabBarItem(
                title: NSLocalizedString(Localization.TabBar.setting, comment: ""),
                image: UIImage(systemName: "text.justify"),
                tag: 2)
        navigationControllers.append(settingNC)
    }
    
}
