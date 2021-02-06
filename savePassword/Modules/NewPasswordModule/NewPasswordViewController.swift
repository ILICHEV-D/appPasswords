
import UIKit

class NewPasswordViewController: UIViewController, NewPasswordViewProtocol {

	var presenter: NewPasswordPresenterProtocol
    
    var button = UIButton()
    private let commonStack = UIStackView()
    private let scrollView = UIScrollView()

//    private let labelMembersTitle = UILabel()
    var stackViewMembers1: UIStackView? //название + скролл
    var stackViewMembers2: UIStackView? //название + скролл
    var stackViewMembers3: UIStackView? //название + скролл
    var stackViewMembers4: UIStackView? //название + скролл

    
//    private let stackListMembers = UIStackView() //внутренний стэк
//    private let scrollViewFriends = UIScrollView() //скролл
//    private let viewForScrollViewFriends = UIView() //view

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
        self.navigationController?.navigationBar.prefersLargeTitles = true
        scrollView.alwaysBounceHorizontal = true

        
        var socialNetworks = [Icons]()
        var travel = [Icons]()
        var games = [Icons]()
        var others = [Icons]()
        
        for i in 0..<Common.listOfIcons.count {
            switch Common.checkType(name: Common.listOfIcons[i].name) {
            case 0:
                socialNetworks.append(Common.listOfIcons[i])
            case 1:
                travel.append(Common.listOfIcons[i])
            case 2:
                games.append(Common.listOfIcons[i])
            default:
                others.append(Common.listOfIcons[i])
            }
        }

        stackViewMembers1 = makeNewLine(name: "Социальные сети", self: self, listOfIcons: socialNetworks)
        stackViewMembers2 = makeNewLine(name: "Путешествия", self: self, listOfIcons: travel)
        stackViewMembers3 = makeNewLine(name: "Игры, развлечения", self: self, listOfIcons: games)

        if !others.isEmpty {
            stackViewMembers4 = makeNewLine(name: "Банки", self: self, listOfIcons: others)
        }

    }

	override func viewDidLoad() {
        super.viewDidLoad()


        presenter.view = self
        presenter.viewDidLoad()
       // setEventAndOrganizerData()

    }
    
    func configure(){
        scrollView.alwaysBounceVertical = true
        commonStack.axis = .vertical

        view.backgroundColor = .white
        button.backgroundColor = .systemBlue
        button.setTitle(Localization.Add.sign, for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        commonStack.spacing = 20
        scrollView.showsHorizontalScrollIndicator = false


    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        presenter.goToAddScreen(name: nil)
    }
    

    @IBAction func pressedMember(_ sender: UIButton) {
        presenter.goToAddScreen(name: (sender.titleLabel?.text)!)
    }
    
    func addAll(){
        self.view.addSubview(scrollView)
        scrollView.addSubview(commonStack)

        [stackViewMembers1!, stackViewMembers2!, stackViewMembers3!, button
        ].forEach({
            commonStack.addArrangedSubview($0)
        });
    }
    
    func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        commonStack.translatesAutoresizingMaskIntoConstraints = false

        button.translatesAutoresizingMaskIntoConstraints = false
        stackViewMembers1!.translatesAutoresizingMaskIntoConstraints = false
        stackViewMembers2!.translatesAutoresizingMaskIntoConstraints = false
        stackViewMembers3!.translatesAutoresizingMaskIntoConstraints = false



        [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
            commonStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            commonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            commonStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            commonStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            commonStack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),


            stackViewMembers1!.heightAnchor.constraint(equalToConstant: 145),
    //        stackViewMembers1!.topAnchor.constraint(equalTo: commonStack.topAnchor, constant: 30),
            stackViewMembers1!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            stackViewMembers1!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            stackViewMembers2!.heightAnchor.constraint(equalToConstant: 145),
    //        stackViewMembers2!.topAnchor.constraint(equalTo: stackViewMembers1!.bottomAnchor, constant: 50),
           stackViewMembers2!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            stackViewMembers2!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
 
            stackViewMembers3!.heightAnchor.constraint(equalToConstant: 145),
    //        stackViewMembers3!.topAnchor.constraint(equalTo: stackViewMembers2!.bottomAnchor, constant: 50),
            stackViewMembers3!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            stackViewMembers3!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
   //         button.topAnchor.constraint(equalTo: stackViewMembers3!.bottomAnchor, constant: 30),
   //         button.heightAnchor.constraint(equalToConstant: 30),
  //          button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
 //           button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
            
        ].forEach({$0.isActive = true})

        
    }


}
