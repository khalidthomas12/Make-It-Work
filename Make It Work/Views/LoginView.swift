//
//  LoginView.swift
//  Make It Work
//
//  Created by Khalid Thomas on 2/2/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var error = ""
    @State private var isLoading = false
    @State private var showHome = false
    
    var body: some View {
        VStack {
            Text("Sign In")
                .font(.largeTitle)
                .foregroundColor(.blue)
            TextField("Email", text: $email)
                .padding()
                .background(Color(.lightGray))
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.lightGray))
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            if error != "" {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                self.signIn()
            }) {
                Text("Sign In")
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.top, 20)
            
            if isLoading {
                ProgressView()
            }
            
        }
        .sheet(isPresented: $showHome) {
            HomeView()
        }
        .padding()
    }
    
    func signIn() {
        isLoading = true
        error = ""
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.error = "Invalid email or password"
                self.isLoading = false
            } else {
                self.showHomeScreen()
            }
        }
    }
    
    func showHomeScreen() {
        self.email = ""
        self.password = ""
        self.isLoading = false
        self.showHome = true
    }
}
