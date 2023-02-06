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
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            ZStack{
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 700, height: 700)
                    .opacity(0.15)
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 700, height: 700)
                    .opacity(0.3)
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 500, height: 500)
                VStack {
                    Spacer()
                    
                    Image(systemName: "figure.highintensity.intervaltraining")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .padding()
                    
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300)
                        .background(.white)
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
                    .background(.white)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                    .padding(.top, 20)
                    
                    NavigationLink(destination: SignUpView()){
                        Text("Sign Up")
                            .foregroundColor(.white)
                    }
                    .padding()
                    Spacer()
                    
                    
                    if isLoading {
                        ProgressView()
                    }
                   
                }
            }
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
                appState.hasOnboarded = true
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


