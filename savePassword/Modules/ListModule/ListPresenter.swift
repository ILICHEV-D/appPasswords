import Foundation
import UIKit

// MARK: View -
protocol ListViewProtocol: class {
}

// MARK: Presenter -
protocol ListPresenterProtocol: class {
	var view: ListViewProtocol? { get set }
    var appDepedency: AppDependency? { get set }
    func viewDidLoad()
    func titleTabBar()
    func goToShowScreen(numberOfRow: Int)
    func updateList()
}

class ListPresenter: ListPresenterProtocol {
    
    weak var view: ListViewProtocol?
    var appDepedency: AppDependency?

    func viewDidLoad() {
        titleTabBar()
    }
    
    func titleTabBar(){
        (self.view as! ListViewController).title = Localization.TabBar.password
    }

    func updateList(){
            let group = DispatchGroup()
            group.enter()
            self.appDepedency?.firestore.loadData()
            group.leave()
            group.notify(queue: .main){
                (self.view as! ListViewController).collectionView.reloadData()
            }
    }
    
    func goToShowScreen(numberOfRow: Int){
        let showPresenter = ShowPasswordPresenter()
        let showVC = ShowPasswordViewController(presenter: showPresenter, numberOfRow: numberOfRow, appDepedency: appDepedency!)
        (self.view as! ListViewController).present(showVC, animated: true, completion: nil)
    }
}
