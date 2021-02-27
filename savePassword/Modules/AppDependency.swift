import Foundation


protocol HasCacheSevice {       //прописываем протокол, которому должен следовать класс
    func articlesCacheService() -> CacheProtocol
}

protocol HasCryptSevice {       //прописываем протокол, которому должен следовать класс
    func articlesCryptSevice() -> CryptProtocol
}

protocol HasFirebaseSercvice {
    func getFirestore() -> TaskRepository
}

class AppDependency {
    let cacheService: CacheProtocol
    let cryptService: CryptProtocol
    let firestore: TaskRepository
    
    init(cacheService: CacheProtocol, cryptCarvice: CryptProtocol, firestore: TaskRepository) {
        self.cacheService = cacheService
        self.cryptService = cryptCarvice
        self.firestore = firestore
    }
    
    static func makeDefault() -> AppDependency {
        let cacheService = CacheService()
        let cryptService = Crypt()
        let firestore = FirestoreTaskRepository()
        return AppDependency(cacheService: cacheService, cryptCarvice: cryptService, firestore: firestore)
    }
    
}

extension AppDependency: HasCacheSevice, HasCryptSevice, HasFirebaseSercvice {
    func articlesCryptSevice() -> CryptProtocol {
        return self.cryptService
    }
    
    func articlesCacheService() -> CacheProtocol {     //расписываем функцию, для соблюдения протокола
        return self.cacheService
    }
    
    func getFirestore() -> TaskRepository {
        return self.firestore
    }
}
