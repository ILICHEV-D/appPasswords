import Foundation
import UIKit

// MARK: View -
protocol NewPasswordViewProtocol: class {
    func addAll()
    func setupConstraints()
    func configure()

}

// MARK: Presenter -
protocol NewPasswordPresenterProtocol: class {
	var view: NewPasswordViewProtocol? { get set }
    var appDepedency: AppDependency? { get set }
    func viewDidLoad()
    func goToAddScreen(name: String?)
}

class NewPasswordPresenter: NewPasswordPresenterProtocol {

    weak var view: NewPasswordViewProtocol?
    var appDepedency: AppDependency?


    func viewDidLoad() {
        view?.addAll()
        view?.configure()
        view?.setupConstraints()
  //      titleTabBar()
    }
    
//    func titleTabBar(){
//        (self.view as! NewPasswordViewController).title = Localization.TabBar.password
//    }
    
    func goToAddScreen(name: String?){
        let addPresenter = AddPresenter()
        let addVC = AddViewController(presenter: addPresenter, appDepedency: appDepedency!)
        
        if let icon = name {
            addPresenter.name = icon
            addVC.iconField.text = icon
        }
        
        (view as! NewPasswordViewController).navigationController?.present(addVC, animated: true, completion: nil)
    }
}
