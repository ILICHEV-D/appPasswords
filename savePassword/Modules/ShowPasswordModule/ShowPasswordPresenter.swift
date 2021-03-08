import Foundation
import UIKit

// MARK: View -
protocol ShowPasswordViewProtocol: class {
    func addAll()
    func configure()
    func setupConstraints()
    func deleteButtonAction()
}

// MARK: Presenter -
protocol ShowPasswordPresenterProtocol: class {
    var view: ShowPasswordViewProtocol? { get set }
    var appDepedency: AppDependency? {get set}
    func viewDidLoad()
    var numberOfRow: Int? { get set}
    func setUpLabels()
    func buttonPressedPresenter()
}

class ShowPasswordPresenter: ShowPasswordPresenterProtocol {
    weak var view: ShowPasswordViewProtocol?
    
    var numberOfRow: Int?
    var appDepedency: AppDependency?
    
    
    
    func viewDidLoad() {
        setUpLabels()
        view?.addAll()
        view?.configure()
        view?.setupConstraints()
    }
    
    func buttonPressedPresenter(){
        appDepedency?.firestore.removeTask(Common.listOfLoginAndPassword[numberOfRow!], completion: {
            (self.view as! ShowPasswordViewController).dismiss(animated: true, completion: nil)
            let listNavigationControllers = ((self.view as! ShowPasswordViewController).presentingViewController as! UITabBarController).viewControllers?[0] as! UINavigationController
            let vc = listNavigationControllers.viewControllers[0] as! ListViewController
            
            DispatchQueue.global().async {
                vc.presenter.updateList()
            }
        })


    }
    
    
    func setUpLabels(){
        if let number = numberOfRow{
            (view as! ShowPasswordViewController).passwordLabel.text = Common.getPassword(number: number, crypt: appDepedency!.cryptService)
            (view as! ShowPasswordViewController).loginLabel.text = String(describing: Common.listOfLoginAndPassword[number].login!)
            (view as! ShowPasswordViewController).nameLabel.text = String(Common.listOfLoginAndPassword[number].type!)
        }
        
    }
    
}
