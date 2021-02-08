//
//  MainCoordinator.swift
//  savePassword
//
//  Created by Danil Ilichev on 06.01.2021.
//

import Foundation
import UIKit

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
    //    listVC.loadViewIfNeeded()
    //    newPasswordVC.loadViewIfNeeded()
   //     settingVC.loadViewIfNeeded()
        
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
        
        listVC.navigationItem.title = Localization.TabBar.password

        listVC.tabBarItem =
            UITabBarItem(
                title: Localization.TabBar.password,
                image: UIImage(systemName: "magnifyingglass"),
                tag: 0)
        navigationControllers.append(listNC)
    }
    
    func setupAdd() {
        let newPasswordPresenter = NewPasswordPresenter()
        let newPasswordVC = NewPasswordViewController(presenter: newPasswordPresenter, appDepedency: appDepedency)
        let newPasswordNC = UINavigationController(rootViewController: newPasswordVC)
        
        newPasswordVC.navigationItem.title = Localization.TabBar.add

    
        newPasswordVC.tabBarItem =
           UITabBarItem(
            title: Localization.TabBar.add,
            image: UIImage(systemName: "plus.circle"),
            tag: 1)
        navigationControllers.append(newPasswordNC)
    }
    
    func setupSetting() {
        let settingPresenter = SettingPresenter()
        let settingVC = SettingViewController(presenter: settingPresenter, appDepedency: appDepedency)
        let settingNC = UINavigationController(rootViewController: settingVC)
    
        settingVC.navigationItem.title = Localization.TabBar.setting
        
        settingVC.tabBarItem =
           UITabBarItem(
            title: Localization.TabBar.setting,
            image: UIImage(systemName: "text.justify"),
            tag: 2)
        navigationControllers.append(settingNC)
    }
    
}
