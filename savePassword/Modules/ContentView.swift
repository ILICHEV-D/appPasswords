import SwiftUI
import Foundation
import FirebaseAuth
import Firebase
import SwiftKeychainWrapper


struct ContentView: View {
    @State var text = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var isNavigationBarHidden: Bool = true

    
    var body: some View {
            VStack {
                Image("launch")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 40)

        
                VStack {
                  Text(NSLocalizedString(Localization.Welcome.welcome, comment: ""))
                    .font(.title)
                  
                  Text("Oclate")
                    .font(.title)
                    .fontWeight(.semibold)
                }

                Text(NSLocalizedString(Localization.Welcome.welcomeDescription, comment: ""))
                    .font(.headline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                  
                Spacer()
                
                                
                SignInWithAppleToFirebase({ response in
                    if response == .success {
                        Auth.auth().addStateDidChangeListener { (auth: Auth, user: User?) in
                            if let user = user {
                                if let email = user.email {
                                    self.text = "\(user.uid), \(email), \(auth)"
                                    KeychainWrapper.standard.set(user.uid, forKey: "uid", withAccessibility: .alwaysThisDeviceOnly, isSynchronizable: false)
                                    NotificationCenter.default.post(name: NSNotification.Name("dismissSwiftUI"), object: nil)
                                }
                            }
                        }
                    } else if response == .error {
                        self.text = "Error"
                    }
                })
                .frame(width: 280, height: 45)
                .padding(.bottom, 30)
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
