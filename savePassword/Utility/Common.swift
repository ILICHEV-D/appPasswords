import Foundation
import UIKit

class Common {
    static var listOfLoginAndPassword = [LoginAndPassword]()
    
    static func addLoginAndPassword(login: String, password: String, icon: String, crypt: CryptProtocol) -> LoginAndPassword{
        
        return LoginAndPassword(login: login, password: crypt.strToSafeCode(str: password, key: crypt.getKey()), type: icon)
    }
    
    static func getPassword(number: Int, crypt: CryptProtocol) -> String {
        let passwords = crypt.safeCodeToStr(array: listOfLoginAndPassword[number].password!, key: crypt.getKey())
        return passwords
    }
}

extension Common {
    
    static var namesOfIcons = ["playstation", "netflix", "skype", "skyscanner", "discord", "twitter", "trivago", "xbox", "reddit", "blizzard", "facebook", "snapchat", "spotify", "booking", "zoom", "instagram", "vk", "airbnb", "tripadvisor", "steam", "origin"]
    
    static var dictionaryOfTypes: [(key: String, value: [String])] = [
        
        ("SocialNetwork", ["skype", "twitter", "reddit", "facebook", "snapchat", "instagram", "vk"]),
        ("Travelling", ["skyscanner", "trivago", "booking", "tripadvisor"]),
        ("GamesEntertainments", [ "playstation", "netflix", "discord", "xbox", "blizzard", "spotify", "steam", "origin"])]
    
    
    static var listOfIcons = [Icons]()
    
    static func getAllIcons(){
        
        for i in namesOfIcons{
            if let image = UIImage(named: "icons/\(i)" ){
                let icon = Icons(name: i, image: image, color: image.averageColor ?? UIColor.systemGray5)
                listOfIcons.append(icon)}
        }
    }
    
    //    static let user1 = UserModel(image: UIImage(named: "1")!, name: "first")
    //    static let user2 = UserModel(image: UIImage(named: "2")!, name: "second")
    //    static let user3 = UserModel(image: UIImage(named: "3")!, name: "third")
}
