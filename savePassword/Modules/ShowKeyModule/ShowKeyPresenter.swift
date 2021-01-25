//
//  ShowKeyPresenter.swift
//  savePassword
//
//  Created Danil Ilichev on 12.01.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Edward
//

import Foundation

// MARK: View -
protocol ShowKeyViewProtocol: class {
    func setupConstraints()
    func addAll()
}

// MARK: Presenter -
protocol ShowKeyPresenterProtocol: class {
	var view: ShowKeyViewProtocol? { get set }
    var appDepedency: AppDependency? {get set}
    func viewDidLoad()
}

class ShowKeyPresenter: ShowKeyPresenterProtocol {

    weak var view: ShowKeyViewProtocol?
    var appDepedency: AppDependency?


    func viewDidLoad() {
        view?.addAll()
        view?.setupConstraints()
    }
}