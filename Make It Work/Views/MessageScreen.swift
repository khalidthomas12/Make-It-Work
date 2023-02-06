//
//  ForumScreen.swift
//  Make It Work
//
//  Created by Khalid Thomas on 2/4/23.
//


import SwiftUI
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase


import SwiftUI

struct MessageScreen: View {
    
    var messageArray = ["Whattup Gang", "How U living", "I'm livin well bro, and you???", "No Complaints"]
                        
    var body: some View {
        VStack{
            TitleBar()
            ScrollView{
                ForEach(messageArray, id: \.self) {text in MessageBubble(message: Message(id: "5431", text: text, received: true, timestamp: Date()))}
                
            }
                
        }
        
    }
}

struct MessageScreen_Preview: PreviewProvider {
    static var previews: some View {
        MessageScreen()
    }
}
