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
    }
    
    
    func goToAddScreen(name: String?){
        let addPresenter = AddPresenter()
        let addVC = AddViewController(presenter: addPresenter, appDepedency: appDepedency!)
        
        if let icon = name {
            addVC.topTitleOfCN.text = icon.firstCapitalized
            addVC.imageOfIcon.image = UIImage(named: "icons/\(icon)" )
            
            let index = Common.listOfIcons.firstIndex(where: {$0.name == icon}) //повт. код
            if let index = index {
                addVC.topView.backgroundColor = Common.listOfIcons[index].color
            }
            else {
                addVC.topView.backgroundColor = UIColor.systemGray5
            }
            
            addPresenter.name = icon
            addVC.iconField.text = icon
        }
        else {
            addVC.topView.backgroundColor = Styles.Color.appBaseColor
            addVC.topTitleOfCN.text = NSLocalizedString(Localization.Add.newPassword, comment: "")
        }
        
        (view as! NewPasswordViewController).navigationController?.present(addVC, animated: true, completion: nil)
    }
}
