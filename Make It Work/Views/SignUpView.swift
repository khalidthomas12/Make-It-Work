//
//  SignUpView.swift
//  Make It Work
//
//  Created by Khalid Thomas on 2/2/23.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var error: String = ""
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .padding()
            TextField("Email", text: $email)
                .padding()
            SecureField("Password", text: $password)
                .padding()
            Button(action: {
                self.signUp()
            }) {
                Text("Sign Up")
            }
            Text(error)
                .foregroundColor(.red)
        }
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
                return
            }
            
            let user = result?.user
            let uid = user?.uid
            let ref = Database.database().reference().child("users").child(uid!)
            let values = ["name": self.name, "email": self.email]
            ref.updateChildValues(values) { (error, ref) in
                if let error = error {
                    self.error = error.localizedDescription
                    return
                }
                
                self.name = ""
                self.email = ""
                self.password = ""
                self.error = ""
            }
        }
    }
}
