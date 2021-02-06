import Foundation
import UIKit

class Common {
    static var listOfLoginAndPassword = [LoginAndPassword]()
    
    static func addLoginAndPassword(login: String, password: String, icon: String, crypt: CryptProtocol){
        listOfLoginAndPassword.append(LoginAndPassword(login: login, password: crypt.strToSafeCode(str: password, key: crypt.getKey()), type: icon))
    }
    
//    static func getLoginAndPasswords() -> [(String, String)]{
//        var array: [(String, String)] = []
//        for i in 0..<listOfLoginAndPassword.count {
//            let passwords = crypt.safeCodeToStr(array: listOfLoginAndPassword[i].password!, key: crypt.key)
//            array.append((listOfLoginAndPassword[i].login!, passwords))
//        }
//        return array
//    }
    
    static func getPassword(number: Int, crypt: CryptProtocol) -> String {
        let passwords = crypt.safeCodeToStr(array: listOfLoginAndPassword[number].password!, key: crypt.getKey())
        return passwords
    }
}

extension Common {
    static var namesOfIcons = ["epicgames", "ps", "netflix", "skype", "skyscanner", "discord", "twitter", "trivago", "xbox", "reddit", "blizzard", "facebook", "snapchat", "spotify", "booking", "zoom", "instagram", "vk", "airbnb", "tripadvisor", "steam", "origin2"]
    
    static func checkType(name: String) -> Int{
        switch name {
        case "skype", "twitter", "reddit", "facebook", "snapchat", "instagram", "vk":
            return 0
        case "skyscanner", "trivago", "booking", "tripadvisor":
            return 1
        case "epicgames", "ps", "netflix", "discord", "xbox", "blizzard", "spotify", "steam", "origin":
            return 2
        default:
            return 3
            }
    }
    
    
    static var listOfIcons = [Icons]()
    
    
    static func getAllIcons(){




        for i in namesOfIcons{
            if let image = UIImage(named: "icons/\(i)" ){
                let icon = Icons(name: i, image: image, color: image.averageColor ?? UIColor.systemGray5)
                listOfIcons.append(icon)}
            }
                print(listOfIcons)
        }
}
