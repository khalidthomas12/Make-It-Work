//
//  ProfileScreen.swift
//  Make It Work
//
//  Created by Khalid Thomas on 2/4/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ImageObservable: ObservableObject {
    
    @Published var image: UIImage = UIImage(systemName: "person.crop.circle")!
    
}

struct ProfileScreen: View {
    
    @State var name: String = ""
    @State var email: String = ""
    @State var image: UIImage?
    @ObservedObject var imageObservable = ImageObservable()
    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                
                Text("Profile Information")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .padding()
                
                Spacer()
                
                Text("Userame")
                    .padding()
                    .frame(width: 300)
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                Text(name)
                    .foregroundColor(.green)
                
                
                Text("Email:")
                    .padding()
                    .frame(width: 300)
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                Text(email)
                    .foregroundColor(.green)
                
                Spacer()
                
                NavigationLink(destination: EditProfileScreen(name: $name, email: $email, image: .constant(imageObservable.image))) {
                    Text("Edit Profile")
                }
                Spacer()
                
            }.onAppear(perform: fetchProfile)
        }
    }
    
    func fetchProfile() {
           let user = Auth.auth().currentUser
           if let user = user {
               let uid = user.uid
               let ref = Database.database().reference().child("users").child(uid)
               ref.observeSingleEvent(of: .value, with: { (snapshot) in
                   let value = snapshot.value as? NSDictionary
                   self.name = value?["name"] as? String ?? ""
                   self.email = value?["email"] as? String ?? ""
                   if let imageUrlString = value?["imageUrl"] as? String, let imageUrl = URL(string: imageUrlString) {
                       URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                           if let error = error {
                               print(error.localizedDescription)
                               return
                           }
                           if let data = data, let uiImage = UIImage(data: data) {
                               DispatchQueue.main.async {
                                   self.imageObservable.image = uiImage
                               }
                           }
                       }.resume()
                   }
               }) { (error) in
                   print(error.localizedDescription)
           }
       }
   }
}
