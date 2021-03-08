import Foundation

//enum ChoicesTitle: String {
//    case choice1 = "Choice 1"
//    case choice2 = "Choice 2"
//    case choice3 = "Choice 3"
//
//    func localizedString() -> String {
//        return NSLocalizedString(self.rawValue, comment: "")
//    }
//
//    static func getTitleFor(title:ChoicesTitle) -> String {
//        print(title)
//        print(title.localizedString())
//        return title.localizedString()
//    }
//}


enum Localization {

    
    enum TabBar {
        static let password = "Passwords"
        static let add = "Add"
        static let setting = "Setting"
    }
    
    enum Password {
        static let buttonDelete = "Delete"
    }
    
    enum Add {
        static let create = "Create"
        static let error = "Error"
        static let errorDescription = "ErrorDescription"
        static let ok = "Ok"
        static let login = "Login"
        static let password = "Password"
        static let name = "Name"
        static let newPassword = "NewPassword"
    }
    
    enum Setting {
        static let showKey = "ShowKey"
        static let changeKey = "ChangeKey"
        static let exit = "Exit"
        static let key = "Key"
        static let keyDescription = "KeyDescription"
        static let changeKeyDescription = "ChangeKeyDescription"
        static let buttonChange = "ButtonChange"
        
        enum Alert {
            static let error = "Error"
            static let messageEmpty = "MessageEmpty"
        }
    }
    
    enum Types {
        static let socialNetwork = "SocialNetwork"
        static let travelling = "Travelling"
        static let gamesEntertainments = "GamesEntertainments"

    }
    
    enum Welcome {
        static let welcomeDescription = "WelcomeDescription"
        static let welcome = "Welcome"
    }
}

