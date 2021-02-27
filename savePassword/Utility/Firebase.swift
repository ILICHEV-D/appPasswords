import Foundation
import FirebaseFirestore 
import FirebaseFirestoreSwift
import Firebase
import SwiftKeychainWrapper

protocol TaskRepository {
    func addTask(_ task: LoginAndPassword)
    func removeTask(_ task: LoginAndPassword)
    //  func updateTask(_ task: LoginAndPassword)
    func loadData()
}


class FirestoreTaskRepository: TaskRepository {
    var db = Firestore.firestore() // (1)
    
    
    
    func loadData() {
        db.collection(KeychainWrapper.standard.string(forKey: "uid") ?? "0").order(by: "createdTime").addSnapshotListener { (querySnapshot, error) in // (2)
            if let querySnapshot = querySnapshot {
                Common.listOfLoginAndPassword = querySnapshot.documents.compactMap { document -> LoginAndPassword? in // !!!!!
                    try? document.data(as: LoginAndPassword.self)
                }
            }
        }
    }
    
    //    db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
    //        self.messages = []
    //        if let e = error{
    
    
    func addTask(_ task: LoginAndPassword) {
        do {
            let _ = try db.collection(KeychainWrapper.standard.string(forKey: "uid")!).addDocument(from: task)
            //    let _ = try db.collection("tasks").addDocument(from: task)
        }
        catch {
            print("There was an error while trying to save a task \(error.localizedDescription).")
        }
    }
    
    //
    //
    //
    //    func updateTask(_ task: LoginAndPassword) {
    //      if let taskID = task.id {
    //        do {
    //          try db.collection("tasks").document(taskID).setData(from: task) // (1)
    //        }
    //        catch {
    //          print("There was an error while trying to update a task \(error.localizedDescription).")
    //        }
    //      }
    //    }
    
    func removeTask(_ task: LoginAndPassword) {
        if let taskID = task.id {
            db.collection(KeychainWrapper.standard.string(forKey: "uid")!).document(taskID).delete { (error) in // (1)
                if let error = error {
                    print("Error removing document: \(error.localizedDescription)")
                }
            }
        }
    }
}
