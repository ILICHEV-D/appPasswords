import UIKit

class ShowPasswordViewController: UIViewController, ShowPasswordViewProtocol {
    
    var presenter: ShowPasswordPresenterProtocol
        
    var commonView = UIView()
    var nameView = UIView()
    var nameLabel = UILabel()
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
        
        view.backgroundColor = .systemBackground
    }
    
    func addAll(){
        view.addSubview(commonView)
        commonView.addSubview(nameView)
        nameView.addSubview(nameLabel)
        
        var previous: UIView?
        
        for i in [(loginLabel, NSLocalizedString(Localization.Add.login, comment: "")), (passwordLabel, NSLocalizedString(Localization.Add.password, comment: ""))]{
            let viewForLP = UIView()
            let label = i.0
            let description = UILabel()
            description.text = i.1
            
            viewForLP.addSubview(label)
            viewForLP.addSubview(description)
            viewForLP.layer.cornerRadius = 20
            commonView.addSubview(viewForLP)
            
            label.textColor = .label
            label.font = UIFont.boldSystemFont(ofSize: 22)
            description.textColor = .secondaryLabel
            description.font = UIFont.boldSystemFont(ofSize: 18)
            
            
            viewForLP.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            description.translatesAutoresizingMaskIntoConstraints = false
            commonView.translatesAutoresizingMaskIntoConstraints = false
            
            [
                viewForLP.widthAnchor.constraint(equalTo: commonView.widthAnchor),
                viewForLP.heightAnchor.constraint(equalToConstant: 80),
                viewForLP.centerXAnchor.constraint(equalTo: commonView.centerXAnchor),
                
                description.topAnchor.constraint(equalTo: viewForLP.topAnchor, constant: 10),
                description.leadingAnchor.constraint(equalTo: viewForLP.leadingAnchor, constant: 10),
                
                label.bottomAnchor.constraint(equalTo: viewForLP.bottomAnchor, constant: -10),
                label.leadingAnchor.constraint(equalTo: viewForLP.leadingAnchor, constant: 10),
            ].forEach({$0.isActive = true})
            
            if let previous = previous {
                viewForLP.topAnchor.constraint(equalTo: previous.bottomAnchor).isActive = true
                viewForLP.addBorder(.top, color: .placeholderText, thickness: 0.3)
            }
            else {
                viewForLP.topAnchor.constraint(equalTo: commonView.topAnchor, constant: 90).isActive = true
                
            }
            previous = viewForLP
        }
        view.addSubview(deleteButton)
    }
    
    func configure(){
        nameView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let index = Common.listOfIcons.firstIndex(where: {$0.name == nameLabel.text})
        if let index = index {
            nameView.backgroundColor = Common.listOfIcons[index].color
        }
        else {
            nameView.backgroundColor = Styles.Color.appBaseColor
        }
        
        nameLabel.text = nameLabel.text?.firstUppercased
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 24)
        
        commonView.backgroundColor = .systemBackground
        
        nameView.layer.cornerRadius = 20
        commonView.layer.cornerRadius = 20
        commonView.layer.shadowRadius = 15
        commonView.layer.shadowOpacity = 0.2
        commonView.layer.shadowColor = UIColor.black.cgColor
        commonView.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        
        deleteButton.setTitle(NSLocalizedString(Localization.Password.buttonDelete, comment: ""), for: .normal)
        deleteButton.backgroundColor = Styles.Color.appBaseColor
        deleteButton.titleLabel?.textColor = .white
        deleteButton.layer.cornerRadius = 15
        deleteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        deleteButton.addTarget(self, action: #selector(self.deleteButtonAction), for: .touchUpInside)
    }
    
    @IBAction func deleteButtonAction(){
        presenter.buttonPressedPresenter()
        
    }
    
    
    func setupConstraints(){
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        commonView.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        [
            commonView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -40),
            commonView.heightAnchor.constraint(equalToConstant: 250),
            commonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            commonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            nameView.widthAnchor.constraint(equalTo: commonView.widthAnchor),
            nameView.heightAnchor.constraint(equalToConstant: 90),
            nameView.topAnchor.constraint(equalTo: commonView.topAnchor),
            nameView.centerXAnchor.constraint(equalTo: commonView.centerXAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: commonView.bottomAnchor, constant: 40),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ].forEach({$0.isActive = true})
    }
    
    
    
}


