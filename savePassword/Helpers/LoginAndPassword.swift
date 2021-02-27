import Foundation
import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

struct LoginAndPassword: Codable{
    @DocumentID var id: String? // (2)
    let login: String?
    let password: Array<UInt32>?
    let type: String?
    @ServerTimestamp var createdTime: Timestamp? // (3)
}

struct Icons{
    var name: String
    var image: UIImage
    var color: UIColor
}
