import Foundation
import SwiftUI
import Firebase
import SwiftKeychainWrapper



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
    func exit()
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
        changeKeyVC.modalPresentationStyle = .fullScreen
        (view as! SettingViewController).navigationController?.pushViewController(changeKeyVC, animated: true)
  //      (view as! SettingViewController).navigationController?.present(changeKeyVC, animated: true, completion: nil)
    }
    
    func mail(){
        
    }
    
    func exit() {
        let listNavigationControllers = (self.view as! SettingViewController).navigationController!
        
        let crypt = Crypt()
        crypt.createKey()
        Common.listOfLoginAndPassword = []
        let vc = UIHostingController(rootView: ContentView())
        NotificationCenter.default.addObserver(forName: NSNotification.Name("dismissSwiftUI"), object: nil, queue: nil) { (_) in
            vc.dismiss(animated: true, completion: nil)
        }
        vc.modalPresentationStyle = .fullScreen
        listNavigationControllers.present(vc, animated: false, completion: {
            listNavigationControllers.tabBarController!.selectedIndex = 0
        })
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("Error when trying to sign out: \(error.localizedDescription)")
        }
        KeychainWrapper.standard.removeObject(forKey: "uid")
        print("sign out")
        
    }
}
