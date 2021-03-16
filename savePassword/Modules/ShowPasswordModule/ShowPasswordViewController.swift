import UIKit

class ShowPasswordViewController: UIViewController, ShowPasswordViewProtocol {
    
    var presenter: ShowPasswordPresenterProtocol
    
    var commonView = UIView()
    var nameView = UIView()
    var nameLabel = UILabel()
    var loginLabel = UILabel()
    var passwordLabel = UILabel()
    var deleteButton = UIButton()
    var shareButton = UIButton()
    var activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [""], applicationActivities: nil)
    
    
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
        view.backgroundColor = UIColor(named: "color2")
    }
    
    func addAll(){
        view.addSubview(commonView)
        commonView.addSubview(nameView)
        nameView.addSubview(shareButton)
        nameView.addSubview(nameLabel)
        
        var previous: UIView?
        
        for i in [(loginLabel, NSLocalizedString(Localization.Add.login, comment: "")), (passwordLabel, NSLocalizedString(Localization.Add.password, comment: ""))]{
            let viewForLP = UIView()
            let label = i.0
            let description = UILabel()
            description.text = i.1
            let copyButton1 = UIButton()
            
            
            viewForLP.addSubview(label)
            viewForLP.addSubview(description)
            viewForLP.layer.cornerRadius = 20
            commonView.addSubview(viewForLP)
            viewForLP.addSubview(copyButton1)
            
            
            label.textColor = .label
            label.font = UIFont.boldSystemFont(ofSize: 22)
            description.textColor = .secondaryLabel
            description.font = UIFont.boldSystemFont(ofSize: 18)
            
            copyButton1.setBackgroundImage(UIImage(systemName: "square.on.square"), for: .normal)
            copyButton1.tintColor = .secondaryLabel
            
            viewForLP.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            description.translatesAutoresizingMaskIntoConstraints = false
            commonView.translatesAutoresizingMaskIntoConstraints = false
            copyButton1.translatesAutoresizingMaskIntoConstraints = false
            
            
            [
                viewForLP.widthAnchor.constraint(equalTo: commonView.widthAnchor),
                viewForLP.heightAnchor.constraint(equalToConstant: 80),
                viewForLP.centerXAnchor.constraint(equalTo: commonView.centerXAnchor),
                
                description.topAnchor.constraint(equalTo: viewForLP.topAnchor, constant: 10),
                description.leadingAnchor.constraint(equalTo: viewForLP.leadingAnchor, constant: 10),
                
                label.trailingAnchor.constraint(equalTo: viewForLP.trailingAnchor, constant: -40),
                label.bottomAnchor.constraint(equalTo: viewForLP.bottomAnchor, constant: -10),
                label.leadingAnchor.constraint(equalTo: viewForLP.leadingAnchor, constant: 10),
                
                copyButton1.rightAnchor.constraint(equalTo: viewForLP.rightAnchor, constant: -10),
                copyButton1.centerYAnchor.constraint(equalTo: viewForLP.centerYAnchor),
                copyButton1.widthAnchor.constraint(equalToConstant: 30),
                copyButton1.heightAnchor.constraint(equalToConstant: 30)
                
            ].forEach({$0.isActive = true})
            
            if let previous = previous {
                viewForLP.topAnchor.constraint(equalTo: previous.bottomAnchor).isActive = true
                viewForLP.addBorder(.top, color: .placeholderText, thickness: 0.3)
                copyButton1.addTarget(self, action: #selector(self.copyOfPasword), for: .touchUpInside)
            }
            else {
                viewForLP.topAnchor.constraint(equalTo: commonView.topAnchor, constant: 90).isActive = true
                copyButton1.addTarget(self, action: #selector(self.copyOfLogin), for: .touchUpInside)
            }
            previous = viewForLP
        }
        view.addSubview(deleteButton)
    }
    
    @IBAction func copyOfLogin(sender: AnyObject) {
        print(loginLabel.text ?? "")
        UIPasteboard.general.string = loginLabel.text ?? ""
    }
    
    @IBAction func copyOfPasword(sender: AnyObject) {
        print(passwordLabel.text ?? "")
        UIPasteboard.general.string = passwordLabel.text ?? ""
    }
    
    @IBAction func sharePasswordAndLoging(sender: AnyObject) {
        activityViewController = UIActivityViewController(activityItems: [loginLabel.text ?? "", passwordLabel.text ?? ""], applicationActivities: nil)
        
        activityViewController.activityItemsConfiguration = [UIActivity.ActivityType.message] as? UIActivityItemsConfigurationReading
        
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissAcrivity))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func dismissAcrivity() {
        activityViewController.dismiss(animated: true, completion: nil)
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
        
        shareButton.setBackgroundImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .white
        shareButton.addTarget(self, action: #selector(self.sharePasswordAndLoging), for: .touchUpInside)
        
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
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            shareButton.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
            shareButton.rightAnchor.constraint(equalTo: nameView.rightAnchor, constant: -10),
            shareButton.widthAnchor.constraint(equalToConstant: 30),
            shareButton.heightAnchor.constraint(equalToConstant: 30),
            
            deleteButton.topAnchor.constraint(equalTo: commonView.bottomAnchor, constant: 40),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ].forEach({$0.isActive = true})
    }
    
    
    
}


