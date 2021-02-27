import Foundation
import UIKit

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}

extension StringProtocol {
    var firstUppercased: String? {
        return prefix(1).uppercased() + dropFirst()
    }
    var firstCapitalized: String? {
        return String(prefix(1)).capitalized + dropFirst()
    }
}
