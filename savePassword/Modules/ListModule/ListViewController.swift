import UIKit

class ListViewController: UIViewController, ListViewProtocol {

	var presenter: ListPresenterProtocol
    
  //  let tableView = UITableView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: CollectionViewFlowLayout())


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
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        setupView()
        self.view = view
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        presenter.updateList()
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.width,
            height: self.view.frame.height)
    }
    
	override func viewDidLoad() {
        self.tabBarController?.tabBar.change(color: Styles.Color.appBaseColor)
        super.viewDidLoad()
        self.definesPresentationContext = true //???
        presenter.view = self
        presenter.viewDidLoad()
    }
    
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(collectionView: collectionView, index: indexPath.row)
        cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.cornerRadius = 15
        cell.layer.shadowRadius = 6
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowColor = UIColor.black.cgColor

        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
//        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Common.listOfLoginAndPassword.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.goToShowScreen(numberOfRow: indexPath.row)
    }
}

private extension ListViewController {
    func setupView() {
        self.collectionView.clipsToBounds = false
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }
}
