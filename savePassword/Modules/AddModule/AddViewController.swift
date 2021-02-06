
import UIKit

class AddViewController: UIViewController, AddViewProtocol {


	var presenter: AddPresenterProtocol
    
    private let commonStack = UIStackView()

    let innerStack = UIStackView()
    
    let iconFieldTitle = UILabel()
    let iconField = UITextView()
    let passwordField = UITextView()
    let passwordFieldTitle = UILabel()
    let loginField = UITextView()
    let loginFieldTitle = UILabel()
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
    
    func configure(){
        commonStack.axis = .vertical
        commonStack.spacing = 15
        
        iconFieldTitle.text = Localization.Add.name
        loginFieldTitle.text = Localization.Add.login
        passwordFieldTitle.text = Localization.Add.password
        
        [passwordFieldTitle, loginFieldTitle, iconFieldTitle].forEach({
            $0.font = .systemFont(ofSize: 15)
            $0.textColor = .black
     //       $0.textColor = UIColor(red: 138/255, green: 138/255, blue: 142/255, alpha: 1)
        })

        [passwordField, loginField, iconField].forEach({
            $0.font = .systemFont(ofSize: 18)
            $0.textColor = .black
            $0.backgroundColor = .systemGray5
            $0.layer.cornerRadius = 15})
        
        cleanButton.backgroundColor = .systemBlue
        cleanButton.setTitle(Localization.Add.sign, for: .normal)
        cleanButton.titleLabel?.textColor = .white
        cleanButton.layer.cornerRadius = 10
    }
    
    func addAll() {
        self.view.addSubview(commonStack)
        
            
        for field in [(iconField, iconFieldTitle),  (loginField, loginFieldTitle), (passwordField, passwordFieldTitle)]{
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 5
            
            stack.translatesAutoresizingMaskIntoConstraints = false
            field.1.translatesAutoresizingMaskIntoConstraints = false
            field.0.translatesAutoresizingMaskIntoConstraints = false
            
            stack.addArrangedSubview(field.1)
            stack.addArrangedSubview(field.0)
            commonStack.addArrangedSubview(stack)
            stack.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
        }
        
        self.view.addSubview(cleanButton)

        
        cleanButton.addTarget(self, action:#selector(self.pressedButton), for: .touchUpInside)
    }

    
    func setupConstraints() {
        commonStack.translatesAutoresizingMaskIntoConstraints = false
        cleanButton.translatesAutoresizingMaskIntoConstraints = false


        
        [
            
            
            commonStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            commonStack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            commonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
       //     commonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
       //     commonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
       //     commonStack.heightAnchor.constraint(equalToConstant: 150),
            
            cleanButton.topAnchor.constraint(equalTo: commonStack.bottomAnchor, constant: 40),
            cleanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            cleanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            cleanButton.heightAnchor.constraint(equalToConstant: 30)

            
        ].forEach({$0.isActive = true})
        
    }

}

