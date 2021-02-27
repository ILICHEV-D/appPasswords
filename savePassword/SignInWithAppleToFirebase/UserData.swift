import Foundation

struct UserData: Codable {
    let email: String
    
    let name: PersonNameComponents
    
    let identifier: String
    
    func displayName(style: PersonNameComponentsFormatter.Style = .default) -> String {
        PersonNameComponentsFormatter.localizedString(from: name, style: style)
    }
}
