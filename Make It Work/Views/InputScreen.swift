//
//  InputScreen.swift
//  Make It Work
//
//  Created by Khalid Thomas on 2/4/23.
//

import SwiftUI
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

struct InputScreen: View {
    var body: some View{
        NavigationView {
            Text("workout screen")
        }
        .navigationTitle("Workout Input")
        .foregroundColor(.blue)
    }
    
}

struct InputScreen_Previews: PreviewProvider {
    static var previews: some View {
        InputScreen()
    }
}
