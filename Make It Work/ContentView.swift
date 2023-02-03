//
//  ContentView.swift
//  Make It Work
//
//  Created by Khalid Thomas on 2/2/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                
                Text("Welcome!")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                    .padding()
                
                
                NavigationLink(" Get Started"){
                    
                    LoginView()
                    
                    
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
