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
    
    static var namesOfIcons = ["epicgames", "ps", "netflix", "skype", "skyscanner", "discord", "twitter", "trivago", "xbox", "reddit", "blizzard", "facebook", "snapchat", "spotify", "booking", "zoom", "instagram", "vk", "airbnb", "tripadvisor", "steam", "origin"]
    
    static var dictionaryOfTypes: [(key: String, value: [String])] = [("Социальные сети", ["skype", "twitter", "reddit", "facebook", "snapchat", "instagram", "vk"]), ("Путешествия", ["skyscanner", "trivago", "booking", "tripadvisor"]), ("Игры, развлечения", ["epicgames", "ps", "netflix", "discord", "xbox", "blizzard", "spotify", "steam", "origin"])]
    
    
    static var listOfIcons = [Icons]()
    
    static func getAllIcons(){
        
        for i in namesOfIcons{
            if let image = UIImage(named: "icons/\(i)" ){
                let icon = Icons(name: i, image: image, color: image.averageColor ?? UIColor.systemGray5)
                listOfIcons.append(icon)}
        }
    }
}
