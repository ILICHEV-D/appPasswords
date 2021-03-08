//
//  ContentView.swift
//  LoginWithAppleFirebaseSwiftUI
//
//  Created by Joseph Hinkle on 12/15/19.
//  Copyright © 2019 Joseph Hinkle. All rights reserved.
//

import SwiftUI
import Foundation
import FirebaseAuth
import Firebase
import SwiftKeychainWrapper


struct ContentView: View {
    @State var text = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                Image("sign")
                    .frame(width: 100, height: 100, alignment: .center)
//                  .resizable()
//                  .aspectRatio(contentMode: .fit)
//                  .padding(.horizontal, 120)
//                  .padding(.top, 0)
                  .padding(.bottom, 100)
                
                Spacer()

                
                Text(NSLocalizedString(Localization.Welcome.welcome, comment: ""))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)


                
                Text(NSLocalizedString(Localization.Welcome.welcomeDescription, comment: ""))
                  .font(.headline)
                  .fontWeight(.medium)
                  .multilineTextAlignment(.center)
             //     .padding(.bottom, 20)
                
                
                
                Text(text)
                SignInWithAppleToFirebase({ response in
                    if response == .success {
                        self.text = "Success"
                        Auth.auth().addStateDidChangeListener { (auth: Auth, user: User?) in
                            if let user = user {
                                if let email = user.email {
                                    self.text = "Successfully logged into Firebase with Sign in with Apple\n\nuser.id: \(user.uid)\nuser.email: \(email)\nauth: \(auth)"
                                    KeychainWrapper.standard.set(user.uid, forKey: "uid", withAccessibility: .alwaysThisDeviceOnly, isSynchronizable: false)
                                    NotificationCenter.default.post(name: NSNotification.Name("dismissSwiftUI"), object: nil)
                                }
                            }
                        }
                    } else if response == .error {
                        self.text = "Error"
                    }
                })
                    .frame(height: 50, alignment: .center)
                    .padding(25)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
            .padding(0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
