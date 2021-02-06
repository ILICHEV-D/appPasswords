import Foundation
import UIKit

struct LoginAndPassword: Codable{
    let login: String?
    let password: Array<UInt32>?
    let type: String?
}

struct Icons{
    var name: String
    var image: UIImage
    var color: UIColor
}
