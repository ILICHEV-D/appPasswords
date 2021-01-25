import Foundation


class Common {
    static var listOfLoginAndPassword = [LoginAndPassword]()
    
    static func addLoginAndPassword(login: String, password: String, crypt: CryptProtocol){
        listOfLoginAndPassword.append(LoginAndPassword(login: login, password: crypt.strToSafeCode(str: password, key: crypt.getKey())))
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
