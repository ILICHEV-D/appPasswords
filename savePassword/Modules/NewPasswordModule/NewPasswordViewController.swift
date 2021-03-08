import UIKit

class NewPasswordViewController: UIViewController, NewPasswordViewProtocol {

	var presenter: NewPasswordPresenterProtocol
    
    private var button = UIButton()
    private let commonStack = UIStackView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()

	init(presenter: NewPasswordPresenterProtocol, appDepedency: AppDependency) {
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
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.viewDidLoad()

    }
    
    func configure(){
        scrollView.alwaysBounceVertical = true
        commonStack.axis = .vertical
        button.backgroundColor = Styles.Color.appBaseColor
        button.setTitle(NSLocalizedString(Localization.Add.create, comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.textColor = .label
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(self.pressedButton), for: .touchUpInside)
        commonStack.spacing = 20
        scrollView.showsVerticalScrollIndicator = false

        for type in Common.dictionaryOfTypes {
            var listIcons = [Icons]()
            for i in 0..<type.value.count {
                listIcons.append(Common.listOfIcons[Common.listOfIcons.firstIndex(where: {$0.name == type.value[i]})!])
            }
            commonStack.addArrangedSubview(makeNewLine(name: type.key, self: self, listOfIcons: listIcons))
        }
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        presenter.goToAddScreen(name: nil)
    }
    

    @IBAction func pressedMember(_ sender: UIButton) {
        presenter.goToAddScreen(name: (sender.titleLabel?.text)!)
    }
    
    func addAll(){
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(commonStack)
        contentView.addSubview(button)
    }
    
    func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        commonStack.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),

            
            commonStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            commonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            commonStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            commonStack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),

            button.topAnchor.constraint(equalTo: commonStack.bottomAnchor, constant: 30),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
      //      button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ].forEach({$0.isActive = true})
        
    }
}
