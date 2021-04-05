import UIKit

class ListViewController: UIViewController, ListViewProtocol {
    
    var presenter: ListPresenterProtocol
    var listOfLogins: [LoginAndPassword] = []
//    private var viewModels = [ListViewModel]()
    
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
        makeSearchController()
        setupView()
        self.view = view
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.width,
            height: self.view.frame.height)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.change(color: Styles.Color.appBaseColor)
        super.viewDidLoad()
        presenter.view = self
        presenter.viewDidLoad()
        presenter.updateList()
        self.definesPresentationContext = true //???
  //      self.setupToHideKeyboardOnTapOnView() //почему-то не работает
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.collectionView.endEditing(true)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) { //???
        super.viewDidDisappear(animated)
        attemptToHideKeyboard()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.reloadEventsWithTheSearch(text: searchText)
    }

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.updateList() //!!!
    }
    
    private func attemptToHideKeyboard() {
        self.navigationItem.searchController?.searchBar.resignFirstResponder()
        self.navigationItem.searchController?.searchBar.endEditing(true)
        self.view.resignFirstResponder()
        self.view.endEditing(true)
    }
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(collectionView: collectionView, index: indexPath.row, listOfLogins: listOfLogins)
        cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.cornerRadius = 15
        cell.layer.shadowRadius = 6
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfLogins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        attemptToHideKeyboard()
        presenter.goToShowScreen(numberOfRow: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        attemptToHideKeyboard()
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
    
    func makeSearchController() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchBar.delegate = self

        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.showsCancelButton = false
   //     navigationController?.navigationBar.isTranslucent = false

        navigationItem.searchController?.searchBar.placeholder = NSLocalizedString(Localization.TabBar.search, comment: "")
//        navigationItem.searchController?.searchBar.backgroundColor = .white
    }
}
