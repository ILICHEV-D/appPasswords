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
        DispatchQueue.global().async {
            self.appDepedency?.cacheService.getDataFromCash()
            DispatchQueue.main.sync {
                (self.view as! ListViewController).collectionView.reloadData()
            }
            print("Успешно обновлен экран")
        }
    }
    
    func goToShowScreen(numberOfRow: Int){
        let showPresenter = ShowPasswordPresenter()
        let showVC = ShowPasswordViewController(presenter: showPresenter, numberOfRow: numberOfRow, appDepedency: appDepedency!)
        (self.view as! ListViewController).present(showVC, animated: true, completion: nil)
    }
}
