import Foundation

// MARK: View -
protocol SettingViewProtocol: class {
    func addAll()
    func setupConstraints()
    func configure()

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
        view?.configure()
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
