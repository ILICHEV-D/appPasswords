import Foundation
import UIKit

// MARK: View -
protocol ListViewProtocol: class {
    var listOfLogins: [LoginAndPassword] {get set}
}

// MARK: Presenter -
protocol ListPresenterProtocol: class {
	var view: ListViewProtocol? { get set }
    var appDepedency: AppDependency? { get set }
    func viewDidLoad()
    func titleTabBar()
    func goToShowScreen(numberOfRow: Int)
    func updateList()
    func reloadEventsWithTheSearch(text: String)
}

class ListPresenter: ListPresenterProtocol {
    
    weak var view: ListViewProtocol?
    var appDepedency: AppDependency?

    func viewDidLoad() {
        titleTabBar()
    }
    
    func titleTabBar(){
        (self.view as! ListViewController).title = NSLocalizedString(Localization.TabBar.password, comment: "")
    }

    func updateList(){

        let fire = FirestoreTaskRepository()
        fire.loadData(completion: {
            self.view?.listOfLogins = Common.listOfLoginAndPassword
            (self.view as! ListViewController).collectionView.reloadData()
        })


    }
    
    func goToShowScreen(numberOfRow: Int){
        let showPresenter = ShowPasswordPresenter()
        let index = Common.listOfLoginAndPassword.firstIndex(where: {$0.id == view?.listOfLogins[numberOfRow].id})!
        let showVC = ShowPasswordViewController(presenter: showPresenter, numberOfRow: index, appDepedency: appDepedency!)
        (self.view as! ListViewController).present(showVC, animated: true, completion: nil)
    }
    
    func reloadEventsWithTheSearch(text: String) {
        if text.isEmpty || text == "" {
            view?.listOfLogins = Common.listOfLoginAndPassword
            (self.view as! ListViewController).collectionView.reloadData()
        }
        else {
            view?.listOfLogins = Common.listOfLoginAndPassword.filter({$0.type!.lowercased().contains(text.lowercased())})
            (self.view as! ListViewController).collectionView.reloadData()
        }
    }
    
}
