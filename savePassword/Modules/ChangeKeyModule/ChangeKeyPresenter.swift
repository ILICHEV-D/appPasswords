import Foundation
import UIKit

// MARK: View -
protocol ChangeKeyViewProtocol: class {
    func addAll()
    func setupConstraints()
    func configure()
}

// MARK: Presenter -
protocol ChangeKeyPresenterProtocol: class {
    var view: ChangeKeyViewProtocol? { get set }
    var appDepedency: AppDependency? { get set }
    func viewDidLoad()
    func changeKey()
}

class ChangeKeyPresenter: ChangeKeyPresenterProtocol {
    
    weak var view: ChangeKeyViewProtocol?
    var appDepedency: AppDependency?
    
    
    func viewDidLoad() {
        view?.addAll()
        view?.setupConstraints()
        view?.configure()
    }
    
    func changeKey() {  //потом исправить
        let key1 = (self.view as! ChangeKeyViewController).keyField1.text ?? "0"
        let key2 = (self.view as! ChangeKeyViewController).keyField2.text ?? "0"
        let key3 = (self.view as! ChangeKeyViewController).keyField3.text ?? "0"
        let key4 = (self.view as! ChangeKeyViewController).keyField4.text ?? "0"
        
        let alertController = UIAlertController(title: NSLocalizedString(Localization.Setting.Alert.error, comment: "") , message: NSLocalizedString(Localization.Setting.Alert.messageEmpty, comment: ""), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        
        if key1.isEmpty || key2.isEmpty || key3.isEmpty || key4.isEmpty{
            (self.view as! ChangeKeyViewController).present(alertController, animated: true, completion: nil)
            return
        }
        
        if (Int(key1)!>4294967295) || (Int(key2)!>4294967295) || (Int(key3)!>4294967295) || (Int(key4)!>4294967295){
            (self.view as! ChangeKeyViewController).present(alertController, animated: true, completion: nil)
            return
        }
        
        
        let key: [UInt32] = [UInt32(Int(key1)!), UInt32(Int(key2)!), UInt32(Int(key3)!), UInt32(Int(key4)!)]
        
        
        appDepedency?.cryptService.changeKey(arrayKey: key)
        
        reloadScreens()
    }
    
    
    func reloadScreens(){
        let tabBarController = (self.view as! ChangeKeyViewController).navigationController?.viewControllers[0].tabBarController
        let listNavigationControllers = tabBarController?.viewControllers?[0] as! UINavigationController
        let vc = listNavigationControllers.viewControllers[0] as! ListViewController
        vc.presenter.updateList()
        
        (self.view as! ChangeKeyViewController).navigationController?.popViewController(animated: true)
        (self.view as! ChangeKeyViewController).dismiss(animated: true, completion: nil)
    }
    
    
}

