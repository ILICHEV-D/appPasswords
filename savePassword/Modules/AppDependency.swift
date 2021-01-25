import Foundation


protocol HasCacheSevice {       //прописываем протокол, которому должен следовать класс
    func articlesCacheService() -> CacheProtocol
}

protocol HasCryptSevice {       //прописываем протокол, которому должен следовать класс
    func articlesCryptSevice() -> CryptProtocol
}

class AppDependency {
    let cacheService: CacheProtocol
    let cryptService: CryptProtocol

    init(cacheService: CacheProtocol, cryptCarvice: CryptProtocol) {
        self.cacheService = cacheService
        self.cryptService = cryptCarvice
    }
    
    static func makeDefault() -> AppDependency {
        let cacheService = CacheService()
        let cryptService = Crypt()
        return AppDependency(cacheService: cacheService, cryptCarvice: cryptService)
    }

}

extension AppDependency: HasCacheSevice, HasCryptSevice {
    func articlesCryptSevice() -> CryptProtocol {
        return self.cryptService
    }
    
    func articlesCacheService() -> CacheProtocol {     //расписываем функцию, для соблюдения протокола
        return self.cacheService
    }
}
