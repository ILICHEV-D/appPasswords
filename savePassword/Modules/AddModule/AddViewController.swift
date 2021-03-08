import UIKit

class AddViewController: UIViewController, AddViewProtocol {
    
    var presenter: AddPresenterProtocol
    
    private let commonStack = UIStackView()
    
    let innerStack = UIStackView()
    
    let topView = UIView()
    let topTitleOfCN = UILabel()
    let imageOfIcon = UIImageView()
    
    let iconFieldTitle = UILabel()
    let iconField = UITextField()
    let passwordField = UITextField()
    let passwordFieldTitle = UILabel()
    let loginField = UITextField()
    let loginFieldTitle = UILabel()
    var cleanButton = UIButton()
    var buttonOfPasswordField = UIButton()
    
    var iconClick = true
    
    
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
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self
        presenter.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        passwordField.isSecureTextEntry = true
    }
    
    @IBAction func iconAction(sender: AnyObject) {
            if(iconClick == true) {
                passwordField.isSecureTextEntry = false
                buttonOfPasswordField.setImage(UIImage(systemName: "lock.circle.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
            } else {
                passwordField.isSecureTextEntry = true
                buttonOfPasswordField.setImage(UIImage(systemName: "lock.circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }

            iconClick = !iconClick
        }
    
    
    func configure(){
        
        buttonOfPasswordField.setImage(UIImage(systemName: "lock.circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buttonOfPasswordField.imageEdgeInsets = UIEdgeInsets(top: 0, left: -25, bottom: 0, right: 0)
        buttonOfPasswordField.frame = CGRect(x: CGFloat(self.passwordField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        buttonOfPasswordField.addTarget(self, action: #selector(self.iconAction), for: .touchUpInside)
        passwordField.rightView = buttonOfPasswordField
        passwordField.rightViewMode = .always
        
        
        
        commonStack.axis = .vertical
        commonStack.spacing = 15
        
        topTitleOfCN.textColor = .white
        topTitleOfCN.font = UIFont.boldSystemFont(ofSize: 30)
        
        iconFieldTitle.text = NSLocalizedString(Localization.Add.name, comment: "")
        loginFieldTitle.text = NSLocalizedString(Localization.Add.login, comment: "")
        passwordFieldTitle.text = NSLocalizedString(Localization.Add.password, comment: "")
        
        [passwordFieldTitle, loginFieldTitle, iconFieldTitle].forEach({
            $0.font = .systemFont(ofSize: 15)
            $0.textColor = .label
            $0.numberOfLines = 1
            $0.lineBreakMode = .byWordWrapping
            
        })
        
        [passwordField, loginField, iconField].forEach({
            $0.font = .systemFont(ofSize: 18)
            $0.textColor = .label
            $0.backgroundColor = .systemGray5
            $0.layer.cornerRadius = 15
            $0.indent(size: 10)
            $0.autocorrectionType = .no
        })
        
        
        var frameRect = passwordField.frame;
        frameRect.size.height = 100; // <-- Specify the height you want here.
        passwordField.frame = frameRect;
        
        cleanButton.backgroundColor = Styles.Color.appBaseColor
        cleanButton.setTitle(NSLocalizedString(Localization.Add.create, comment: ""), for: .normal)
        cleanButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cleanButton.titleLabel?.textColor = .systemBackground
        cleanButton.layer.cornerRadius = 15
    }
    
    
    @IBAction func pressedButton(_ sender: UIButton) {
        presenter.buttonPressedPresenter()
    }
    
    func addAll() {
        self.view.addSubview(topView)
        self.view.addSubview(commonStack)
        
        //     topView.addSubview(imageOfIcon)
        topView.addSubview(topTitleOfCN)
        
        var stackOfField: [(UITextField, UILabel)] = []
        if presenter.name == nil {
            stackOfField = [(iconField, iconFieldTitle),  (loginField, loginFieldTitle), (passwordField, passwordFieldTitle)]
        }
        else {
            stackOfField = [(loginField, loginFieldTitle), (passwordField, passwordFieldTitle)]
        }
        for field in stackOfField {
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
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        loginField.translatesAutoresizingMaskIntoConstraints = false
        iconField.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        topTitleOfCN.translatesAutoresizingMaskIntoConstraints = false
        
        [
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topView.heightAnchor.constraint(equalToConstant: 100),
            
            topTitleOfCN.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topTitleOfCN.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 25),
            
            passwordField.heightAnchor.constraint(equalToConstant: 35),
            loginField.heightAnchor.constraint(equalToConstant: 35),
            iconField.heightAnchor.constraint(equalToConstant: 35),
            
            commonStack.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 25),
            commonStack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            commonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cleanButton.topAnchor.constraint(equalTo: commonStack.bottomAnchor, constant: 40),
            cleanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            cleanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            cleanButton.heightAnchor.constraint(equalToConstant: 35)
            
        ].forEach({$0.isActive = true})
        
    }
    
}

