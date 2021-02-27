import Foundation

protocol CacheProtocol {
    func getDataFromCash()
    func downloadDataToCash()
}

class CacheService: CacheProtocol {
    
    var cachesDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] + "/data"
    
    func getDataFromCash(){
        if FileManager.default.fileExists(atPath: cachesDir) {
            if let data = FileManager.default.contents(atPath: cachesDir){
                let listOfLoginAndPassword = try? PropertyListDecoder().decode([LoginAndPassword].self, from: data)
                Common.listOfLoginAndPassword = listOfLoginAndPassword ?? [] //!!!
                print("Успешно скачано из кэша")
            }
        }
    }
    
    func downloadDataToCash(){
        let data = try? PropertyListEncoder().encode(Common.listOfLoginAndPassword)   //!!!
        FileManager.default.createFile(atPath: cachesDir, contents: data!, attributes: nil) //!!!
        print("Успешно загружено в кэш")
    }
    
    
}
