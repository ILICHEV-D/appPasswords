import UIKit

class ListViewController: UIViewController, ListViewProtocol {

	var presenter: ListPresenterProtocol
    
    let tableView = UITableView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))


    init(presenter: ListPresenterProtocol, appDepedency: AppDependency) {
        self.presenter = presenter
        self.presenter.appDepedency = appDepedency
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView()
        tableView.alwaysBounceVertical = true
        view.addSubview(tableView)
        view.backgroundColor = #colorLiteral(red: 0.9567590356, green: 0.9569227099, blue: 0.9567485452, alpha: 1)
        self.view = view
        presenter.updateList()
    }
    
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self
        presenter.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Common.listOfLoginAndPassword.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        let password = Common.getPassword(number: indexPath.row, crypt: presenter.appDepedency!.cryptService as! Crypt)
  
        var configurration = cell.defaultContentConfiguration()
        configurration.text = String(describing: Common.listOfLoginAndPassword[indexPath.row].login!)
        configurration.secondaryText = password
        
        cell.contentConfiguration = configurration
        
    
        return cell
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.goToShowScreen(numberOfRow: indexPath.row)
    }
}
