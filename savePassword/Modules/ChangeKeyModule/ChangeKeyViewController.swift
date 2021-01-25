import UIKit

class ChangeKeyViewController: UIViewController, ChangeKeyViewProtocol {

	var presenter: ChangeKeyPresenterProtocol
    
    var label = UILabel()
    var keyField1 = UITextField()
    var keyField2 = UITextField()
    var keyField3 = UITextField()
    var keyField4 = UITextField()
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
        
        view.backgroundColor = .white
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
        label.text = Localization.Setting.changeKey

        button.backgroundColor = .systemBlue
        button.setTitle(Localization.Setting.buttonChange, for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        
        [keyField1, keyField2, keyField3, keyField4
        
        ].forEach({$0.backgroundColor = .systemGray})

        
        button.addTarget(self, action: #selector(self.pressedButton), for: .touchUpInside)
    }
    
        

    
    func addAll(){
        view.addSubview(label)
        view.addSubview(keyField1)
        view.addSubview(keyField2)
        view.addSubview(keyField3)
        view.addSubview(keyField4)
        view.addSubview(button)
    }
    
    func setupConstraints(){
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        keyField1.translatesAutoresizingMaskIntoConstraints = false
        keyField2.translatesAutoresizingMaskIntoConstraints = false
        keyField3.translatesAutoresizingMaskIntoConstraints = false
        keyField4.translatesAutoresizingMaskIntoConstraints = false

        [
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            keyField1.widthAnchor.constraint(equalToConstant: 200),
            keyField1.heightAnchor.constraint(equalToConstant: 30),
            keyField1.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            keyField1.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            keyField2.widthAnchor.constraint(equalToConstant: 200),
            keyField2.heightAnchor.constraint(equalToConstant: 30),
            keyField2.topAnchor.constraint(equalTo: keyField1.bottomAnchor, constant: 40),
            keyField2.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            keyField3.widthAnchor.constraint(equalToConstant: 200),
            keyField3.heightAnchor.constraint(equalToConstant: 30),
            keyField3.topAnchor.constraint(equalTo: keyField2.bottomAnchor, constant: 40),
            keyField3.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            keyField4.widthAnchor.constraint(equalToConstant: 200),
            keyField4.heightAnchor.constraint(equalToConstant: 30),
            keyField4.topAnchor.constraint(equalTo: keyField3.bottomAnchor, constant: 40),
            keyField4.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: keyField4.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
  
        ].forEach({$0.isActive = true})

    }
}
