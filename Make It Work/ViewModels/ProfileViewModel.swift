//
//  UserViewModel.swift
//  Make It Work
//
//  Created by Khalid Thomas on 2/2/23.
//

import SwiftUI
import UIKit
import FirebaseStorage
import FirebaseDatabase
import Firebase

// Get the profile from Firebase
class ProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var image = UIImage()
    
    
    init() {
        fetchProfile()
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
                                self.image = uiImage
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

//Allow user to choose profile image

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(isShown: $isShown, image: $image)
    }
}

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @Binding var isShown: Bool
    @Binding var image: UIImage?

    init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
        _isShown = isShown
        _image = image
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        image = uiImage
        isShown = false
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}





