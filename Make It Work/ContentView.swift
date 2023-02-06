//
//  ContentView.swift
//  Make It Work
//
//  Created by Khalid Thomas on 2/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showLoginView = false
    @EnvironmentObject var appState: AppState
    
    var body: some View {
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
                
                Text("Welcome!")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                
                Button(action: {
                    self.showLoginView.toggle()
                }) {
                    Text("Click Here to Get Started")
                        .padding()
                        .foregroundColor(.blue)
                        .background(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showLoginView) {
                    LoginView()
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


