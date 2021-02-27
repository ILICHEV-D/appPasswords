import UIKit

class ShowKeyViewController: UIViewController, ShowKeyViewProtocol {
    
    var presenter: ShowKeyPresenterProtocol
    
    var keyLabel = UILabel()
    var keyDescriptionLabel = UILabel()
    var stackKey = UIStackView()
    
    
    
    
    init(presenter: ShowKeyPresenterProtocol, appDepedency: AppDependency) {
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
        
        stackKey.spacing = 10
        stackKey.axis = .vertical
        stackKey.alignment = .center
    }
    
    func addAll(){
        view.addSubview(keyLabel)
        view.addSubview(keyDescriptionLabel)
        view.addSubview(stackKey)
        
        let key = presenter.appDepedency?.cryptService.getKey()
        
        
        
        for i in 0...3 {
            let keyLable = UILabel()
            keyLable.translatesAutoresizingMaskIntoConstraints = false
            keyLable.textColor = .label
            keyLable.font = UIFont.boldSystemFont(ofSize: 20)
            keyLable.text = String((key?[i])!)
            stackKey.addArrangedSubview(keyLable)
        }
    }
    
    func setupConstraints(){
        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        keyDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        stackKey.translatesAutoresizingMaskIntoConstraints = false
        
        [
            keyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            keyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            keyDescriptionLabel.topAnchor.constraint(equalTo: keyLabel.bottomAnchor, constant: 15),
            keyDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            keyDescriptionLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -40),
            
            stackKey.topAnchor.constraint(equalTo: keyDescriptionLabel.bottomAnchor, constant: 30),
            stackKey.widthAnchor.constraint(equalToConstant: 150),
            stackKey.heightAnchor.constraint(equalToConstant: 120),
            stackKey.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
        ].forEach({$0.isActive = true})
        
    }
    
}
