//
//  EditProfileScreen.swift
//  Make It Work
//
//  Created by Khalid Thomas on 2/4/23.
//


import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseDatabase

struct EditProfileScreen: View {
    
    @Binding var name: String
    @Binding var email: String
    @Binding var image: UIImage?
    @State var error: String = ""
    @State var message: String = ""
    @State var currentPassword: String = ""
    @State var newPassword: String = ""
    @State var confirmPassword: String = ""
    @State private var showImagePicker: Bool = false
    
    
    var body: some View {
        
        Text("Edit Profile Information")
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .foregroundColor(.blue)
            .padding()
        
        VStack {
            
            Spacer()
            
            Text("Username:")
            TextField("Username", text: $name)
                .padding()
                .background(Color(.lightGray))
                .frame(width: 300)
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            Text("Email:")
            TextField("Email", text: $email)
                .padding()
                .background(Color(.lightGray))
                .frame(width: 300)
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            
            Text("Contact Administrator to Reset Password or Delete Account")
                .multilineTextAlignment(.center)
                .font(.footnote)
            
            Spacer()
            
            Button(action: {
                self.saveChanges()
            }) {
                Text("Save Changes")
                    .padding()
                    .cornerRadius(10)
            }
            
            Spacer()
            
            if message != "" {
                Text(message)
                    .foregroundColor(.green)
            }
        }
    }
    
    
    
    func saveChanges() {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let storageRef = Storage.storage().reference().child("profile_images").child(uid)
            if let image = self.image, let imageData = image.jpegData(compressionQuality: 0.75) {
                storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                    if let error = error {
                        self.error = error.localizedDescription
                        self.message = ""
                        return
                    }
                    
                    storageRef.downloadURL { (url, error) in
                        if let error = error {
                            self.error = error.localizedDescription
                            self.message = ""
                            return
                        }
                        
                        guard let url = url else { return }
                        let ref = Database.database().reference().child("users").child(uid)
                        let values = ["name": self.name, "email": self.email, "imageUrl": url.absoluteString]
                        ref.updateChildValues(values) { (error, ref) in
                            if let error = error {
                                self.error = error.localizedDescription
                                self.message = ""
                                return
                            }
                            
                            self.error = ""
                            self.message = "Profile updated!"
                        }
                    }
                }
            }
        }
    }
}

