//
//  SettingPresenter.swift
//  savePassword
//
//  Created Danil Ilichev on 06.01.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Edward
//

import Foundation

// MARK: View -
protocol SettingViewProtocol: class {
    func addAll()
    func setupConstraints()

}

// MARK: Presenter -
protocol SettingPresenterProtocol: class {
	var view: SettingViewProtocol? { get set }
    var appDepedency: AppDependency? { get set }
    func viewDidLoad()
    func goToShowKey()
    func goToChangeKey()
}

class SettingPresenter: SettingPresenterProtocol {

    weak var view: SettingViewProtocol?
    var appDepedency: AppDependency?


    func viewDidLoad() {
        view?.addAll()
        view?.setupConstraints()
    }
    
    func goToShowKey(){
        let showKeyPresenter = ShowKeyPresenter()
        let showKeyVC = ShowKeyViewController(presenter: showKeyPresenter, appDepedency: appDepedency!)
        (view as! SettingViewController).navigationController?.present(showKeyVC, animated: true, completion: nil)
    }
    
    func goToChangeKey(){
        let changeKeyPresenter = ChangeKeyPresenter()
        let changeKeyVC = ChangeKeyViewController(presenter: changeKeyPresenter, appDepedency: appDepedency!)
        (view as! SettingViewController).navigationController?.present(changeKeyVC, animated: true, completion: nil)
    }
}
