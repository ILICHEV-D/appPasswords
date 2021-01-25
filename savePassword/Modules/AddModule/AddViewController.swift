
import UIKit

class AddViewController: UIViewController, AddViewProtocol {


	var presenter: AddPresenterProtocol
    
    let passwordField = UITextView()
    let loginField = UITextView()
    var cleanButton = UIButton()


	init(presenter: AddPresenterProtocol, appDepedency: AppDependency) {
        self.presenter = presenter
        self.presenter.appDepedency = appDepedency
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = .white
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.viewDidLoad()
    }
    
    
    @IBAction func pressedButton(_ sender: UIButton) {
        presenter.buttonPressedPresenter()
    }
    
    func addAll() {
        self.view.addSubview(loginField)
        self.view.addSubview(passwordField)
        self.view.addSubview(cleanButton)

        cleanButton.addTarget(self, action:#selector(self.pressedButton), for: .touchUpInside)
    }

    
    func setupConstraints() {

        loginField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        cleanButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginField.font = .systemFont(ofSize: 20)
        loginField.textColor = .black
        loginField.backgroundColor = .systemGray5
        loginField.layer.cornerRadius = 15
        
        passwordField.font = .systemFont(ofSize: 20)
        passwordField.textColor = .black
        passwordField.backgroundColor = .systemGray5
        passwordField.layer.cornerRadius = 15
        
        cleanButton.backgroundColor = .systemBlue
        cleanButton.setTitle(Localization.Add.sign, for: .normal)
        cleanButton.titleLabel?.textColor = .white
        cleanButton.layer.cornerRadius = 10
        
        
        [
            loginField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            loginField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 30),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            
            cleanButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
            cleanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            cleanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            cleanButton.heightAnchor.constraint(equalToConstant: 30)

            
        ].forEach({$0.isActive = true})
        
    }

}

