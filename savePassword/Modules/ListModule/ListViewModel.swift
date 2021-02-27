import Foundation

struct ListViewModel {
    let index: Int
    let name: String
    let login: String
    let password: String
    
    
    init(index: Int, name: String, login: String, password: String) {
        self.index = index
        self.name = name
        self.login = login
        self.password = password
    }
}
