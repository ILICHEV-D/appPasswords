import UIKit

class ChangeKeyViewController: UIViewController, ChangeKeyViewProtocol {

	var presenter: ChangeKeyPresenterProtocol
    
    var keyLabel = UILabel()
    var keyDescriptionLabel = UILabel()
    var keyField1 = UITextField()
    var keyField2 = UITextField()
    var keyField3 = UITextField()
    var keyField4 = UITextField()
    var stackKey = UIStackView()
    var button = UIButton()


	init(presenter: ChangeKeyPresenterProtocol, appDepedency: AppDependency) {
        self.presenter = presenter
        self.presenter.appDepedency = appDepedency
        super.init(nibName: nil, bundle: nil)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        self.view = view
        
        view.backgroundColor = .systemBackground
    }

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.viewDidLoad()
    }
    
    @objc func pressedButton(){
        presenter.changeKey()
    }
    
    func configure(){
        keyLabel.text = Localization.Setting.key
        keyLabel.textColor = .label
        keyLabel.font = UIFont.boldSystemFont(ofSize: 22)
        keyDescriptionLabel.text = Localization.Setting.keyDescriotion
        keyDescriptionLabel.textColor = .secondaryLabel
        keyDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        keyLabel.textAlignment = .center
        keyDescriptionLabel.textAlignment = .center
        
        keyDescriptionLabel.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
        keyDescriptionLabel.numberOfLines = 0
        
        stackKey.spacing = 15
        stackKey.axis = .vertical
        stackKey.alignment = .center
        
        button.backgroundColor = .systemBlue
        button.setTitle(Localization.Setting.buttonChange, for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        
        [keyField1, keyField2, keyField3, keyField4

        ].forEach({
            $0.layer.cornerRadius = 10
            $0.keyboardType = .numberPad
            $0.backgroundColor = .systemGray5
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textColor = .label
            $0.font = UIFont.boldSystemFont(ofSize: 25)
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 180).isActive = true
            stackKey.addArrangedSubview($0)
        })

        
        button.addTarget(self, action: #selector(self.pressedButton), for: .touchUpInside)
    }
    
        

    
    func addAll(){
        view.addSubview(keyLabel)
        view.addSubview(keyDescriptionLabel)
        view.addSubview(stackKey)
        view.addSubview(button)
    }
    
    func setupConstraints(){
        button.translatesAutoresizingMaskIntoConstraints = false
        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        keyDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        stackKey.translatesAutoresizingMaskIntoConstraints = false
//        keyField1.translatesAutoresizingMaskIntoConstraints = false
//        keyField2.translatesAutoresizingMaskIntoConstraints = false
//        keyField3.translatesAutoresizingMaskIntoConstraints = false
//        keyField4.translatesAutoresizingMaskIntoConstraints = false

        [
            keyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            keyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            keyDescriptionLabel.topAnchor.constraint(equalTo: keyLabel.bottomAnchor, constant: 15),
            keyDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            keyDescriptionLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -40),
            
            stackKey.topAnchor.constraint(equalTo: keyDescriptionLabel.bottomAnchor, constant: 30),
            stackKey.widthAnchor.constraint(equalToConstant: 165),
            stackKey.heightAnchor.constraint(equalToConstant: 205),
            stackKey.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: stackKey.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -60)
  
        ].forEach({$0.isActive = true})

    }
}
