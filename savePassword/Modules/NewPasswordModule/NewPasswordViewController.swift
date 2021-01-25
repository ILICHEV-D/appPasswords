//
//  NewPasswordViewController.swift
//  savePassword
//
//  Created Danil Ilichev on 12.01.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Edward
//

import UIKit

class NewPasswordViewController: UIViewController, NewPasswordViewProtocol {

	var presenter: NewPasswordPresenterProtocol
    
    var button = UIButton()

	init(presenter: NewPasswordPresenterProtocol, appDepedency: AppDependency) {
        self.presenter = presenter
        self.presenter.appDepedency = appDepedency
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = .white
    }

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.viewDidLoad()
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        presenter.goToAddScreen()
    }
    
    func addAll(){
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(self.pressedButton), for: .touchUpInside)
    }
    
    func setupConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .systemBlue
        button.setTitle(Localization.Add.sign, for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        
        [
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      //      button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
      //      button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            button.heightAnchor.constraint(equalToConstant: 30)
            
        ].forEach({$0.isActive = true})

        
    }

   
}
