import Foundation
import FirebaseFirestore 
import FirebaseFirestoreSwift
import Firebase
import SwiftKeychainWrapper

protocol TaskRepository {
    func addTask(_ task: LoginAndPassword, completion: @escaping () -> Void)
    func removeTask(_ task: LoginAndPassword, completion: @escaping () -> Void)
    func loadData(completion: @escaping () -> Void)
}


class FirestoreTaskRepository: TaskRepository {
    
    var db = Firestore.firestore()
    
    func loadData (completion: @escaping () -> Void = {}) {
        db.collection(KeychainWrapper.standard.string(forKey: "uid") ?? "0").order(by: "createdTime").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                Common.listOfLoginAndPassword = querySnapshot.documents.compactMap { document -> LoginAndPassword?
                    in
                    try? document.data(as: LoginAndPassword.self)
                }
                Common.listOfLoginAndPassword.reverse() //!!!
                completion()
            }
        }
    }
    
    func addTask(_ task: LoginAndPassword, completion: @escaping () -> Void = {}) {
        do {
            let _ = try db.collection(KeychainWrapper.standard.string(forKey: "uid")!).addDocument(from: task)
        }
        catch {
            print("There was an error while trying to save a task \(error.localizedDescription).")
        }
        completion()
    }
    
    
    func removeTask(_ task: LoginAndPassword, completion: @escaping () -> Void = {}) {
        if let taskID = task.id {
            db.collection(KeychainWrapper.standard.string(forKey: "uid")!).document(taskID).delete { (error) in // (1)
                if let error = error {
                    print("Error removing document: \(error.localizedDescription)")
                }
            }
        }
        completion()
    }
}
