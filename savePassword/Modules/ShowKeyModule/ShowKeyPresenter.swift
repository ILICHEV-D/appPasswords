import Foundation

// MARK: View -
protocol ShowKeyViewProtocol: class {
    func setupConstraints()
    func addAll()
    func configure()
}

// MARK: Presenter -
protocol ShowKeyPresenterProtocol: class {
    var view: ShowKeyViewProtocol? { get set }
    var appDepedency: AppDependency? {get set}
    func viewDidLoad()
}

class ShowKeyPresenter: ShowKeyPresenterProtocol {
    
    weak var view: ShowKeyViewProtocol?
    var appDepedency: AppDependency?
    
    
    func viewDidLoad() {
        view?.addAll()
        view?.setupConstraints()
        view?.configure()
    }
}
