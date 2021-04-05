import UIKit
import MessageUI



class SettingViewController: UIViewController, SettingViewProtocol, MFMailComposeViewControllerDelegate {
    
    var presenter: SettingPresenterProtocol
    
    private let tableView = UITableView()
    
    
    init(presenter: SettingPresenterProtocol, appDepedency: AppDependency) {
        self.presenter = presenter
        self.presenter.appDepedency = appDepedency
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        tableView.alwaysBounceVertical = true
        self.view = view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        tableView.delegate = self
    }
    
 
    
    func configure(){
        view.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        
    }
    
    func addAll(){
        view.addSubview(tableView)
    }
    
    
    func setupConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ].forEach({$0.isActive = true})
    }
    
}


extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = NSLocalizedString(Localization.Setting.showKey, comment: "")
        case 1:
            cell.textLabel?.text = NSLocalizedString(Localization.Setting.changeKey, comment: "")
        case 2:
            cell.textLabel?.text = NSLocalizedString(Localization.Setting.contact, comment: "")
        case 3:
            cell.textLabel?.text = NSLocalizedString(Localization.Setting.exit, comment: "")  
        default:
            cell.textLabel?.text = "error"
        }
        return cell
    }
    
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            presenter.goToShowKey()
        case 1:
            presenter.goToChangeKey()
        case 2:
            let mailComposeViewController = configureMailComposer()
              if MFMailComposeViewController.canSendMail() {
                  self.present(mailComposeViewController, animated: true, completion: nil)
              } else {
                  print("Can't send email")
              }
        case 3:
            let alert = UIAlertController(title: NSLocalizedString(Localization.Setting.warning, comment: ""), message: NSLocalizedString(Localization.Setting.warningDescription, comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString(Localization.Setting.cancel, comment: ""), style: .cancel, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString(Localization.Setting.exit, comment: ""), style: .destructive, handler: { _ in self.presenter.exit()
            }))
            self.present(alert, animated: true, completion: nil)
            
        default:
            print("error")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func configureMailComposer() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["danil.ilich@icloud.com"])
        mailComposeVC.setSubject("Oclate")
        mailComposeVC.setMessageBody("", isHTML: false)
        return mailComposeVC
    }
}
