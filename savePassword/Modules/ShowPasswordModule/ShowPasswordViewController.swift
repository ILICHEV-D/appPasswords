import UIKit

class ShowPasswordViewController: UIViewController, ShowPasswordViewProtocol {

	var presenter: ShowPasswordPresenterProtocol
    
    var loginLabel = UILabel()
    var passwordLabel = UILabel()
    var deleteButton = UIButton()

    init(presenter: ShowPasswordPresenterProtocol, numberOfRow: Int, appDepedency: AppDependency) {
        self.presenter = presenter
        self.presenter.appDepedency = appDepedency
        self.presenter.numberOfRow = numberOfRow
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.viewDidLoad()
    }
    
    override func loadView() {
        let view = UIView()
        self.view = view
        
        view.backgroundColor = .white
    }
    
    func addAll(){
        view.addSubview(loginLabel)
        view.addSubview(passwordLabel)
        view.addSubview(deleteButton)
    }
    
    func configure(){
        deleteButton.setTitle(Localization.Password.buttonDelete, for: .normal)
        deleteButton.backgroundColor = .systemBlue
        deleteButton.titleLabel?.textColor = .white
        deleteButton.layer.cornerRadius = 10
        
        deleteButton.addTarget(self, action: #selector(self.deleteButtonAction), for: .touchUpInside)
    }
    
    @IBAction func deleteButtonAction(){
        presenter.buttonPressedPresenter()
    }
    
    
    func setupConstraints(){
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        [
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 40),
            passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            deleteButton.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 40),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ].forEach({$0.isActive = true})
    }
    


}
