import Foundation
import UIKit
import Combine
import Firebase

// MARK: View -
protocol AddViewProtocol: class {
    func addAll()
    func setupConstraints()
    func configure()
    
}

// MARK: Presenter -
protocol AddPresenterProtocol: class {
    var view: AddViewProtocol? { get set }
    var appDepedency: AppDependency? {get set}
    var name: String? { get }
    func viewDidLoad()
    func buttonPressedPresenter()
}

class AddPresenter: AddPresenterProtocol {
    
    weak var view: AddViewProtocol?
    var appDepedency: AppDependency?
    var name: String?
    
    
    func viewDidLoad() {
        view?.addAll()
        view?.setupConstraints()
        view?.configure()
    }
    
    func buttonPressedPresenter(){
        let login = (self.view as! AddViewController).loginField.text ?? ""
        let password = (self.view as! AddViewController).passwordField.text ?? ""
        let icon = (self.view as! AddViewController).iconField.text ?? ""
        
        let alertController = UIAlertController(title: NSLocalizedString(Localization.Add.error, comment: ""), message: NSLocalizedString(Localization.Add.errorDescription, comment: ""), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString(Localization.Add.ok, comment: ""), style: .cancel, handler: nil))
        
        if login.isEmpty || password.isEmpty || icon.isEmpty {
            (self.view as! AddViewController).present(alertController, animated: true, completion: nil)
            return
        }
        
        
        let alertController2 = UIAlertController(title: NSLocalizedString(Localization.Add.error, comment: ""), message: NSLocalizedString(Localization.Add.tooLong, comment: ""), preferredStyle: .alert)
        alertController2.addAction(UIAlertAction(title: NSLocalizedString(Localization.Add.ok, comment: ""), style: .cancel, handler: nil))
        
        if login.count > 40 || password.count > 50 {
            (self.view as! AddViewController).present(alertController2, animated: true, completion: nil)
            return
        }
        
        
        let item = Common.addLoginAndPassword(login: login, password: password, icon: name ?? icon, crypt: appDepedency!.cryptService)
        

        appDepedency?.firestore.addTask(item, completion: {
            self.reloadScreens()
        })
        
        
        (self.view as! AddViewController).loginField.text = ""
        (self.view as! AddViewController).passwordField.text = ""
        (self.view as! AddViewController).iconField.text = ""
        
   //     self.reloadScreens()
    }
    
    func reloadScreens(){
        (self.view as! AddViewController).dismiss(animated: true, completion: nil)
        
        let listNavigationControllers = ((self.view as! AddViewController).presentingViewController as! UITabBarController).viewControllers?[0] as! UINavigationController
        let vc = listNavigationControllers.viewControllers[0] as! ListViewController
        
        DispatchQueue.global().async {
            vc.presenter.updateList()
        }
    }
}

