//
//  SettingViewController.swift
//  savePassword
//
//  Created Danil Ilichev on 06.01.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Edward
//

import UIKit

class SettingViewController: UIViewController, SettingViewProtocol {

	var presenter: SettingPresenterProtocol
    
    private let tableView = UITableView()


    init(presenter: SettingPresenterProtocol, appDepedency: AppDependency) {
        self.presenter = presenter
        self.presenter.appDepedency = appDepedency
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView()
        tableView.alwaysBounceVertical = true
    //    view.addSubview(tableView)
        view.backgroundColor = #colorLiteral(red: 0.9567590356, green: 0.9569227099, blue: 0.9567485452, alpha: 1)
        self.view = view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self
        presenter.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func addAll(){
        view.addSubview(tableView)
    }

    
    

    func setupConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false


        [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ].forEach({$0.isActive = true})


    }

}


extension SettingViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
    switch indexPath.row {
    case 0:
        cell.textLabel?.text = Localization.Setting.showKey
    case 1:
        cell.textLabel?.text = Localization.Setting.changeKey
    default:
        cell.textLabel?.text = "error"
    }
    return cell
  }
    
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            presenter.goToShowKey()
        case 1:
            presenter.goToChangeKey()
        default:
            print("error")
        }
    }
}
