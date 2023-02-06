//
//  HomeView.swift
//  Make It Work
//
//  Created by Khalid Thomas on 2/2/23.
//

import SwiftUI
import Firebase

struct HomeView: View{
    
    @EnvironmentObject var appState: AppState
    
    
    var body: some View{
        TabView(){
            WelcomeScreen()
                .tabItem {
                    Image(systemName: "network")
                }
            
            InputScreen()
                .tabItem {
                    Image(systemName: "square.and.arrow.up.circle.fill")
                }
            
            MessageScreen()
                .tabItem {
                    Image(systemName: "text.bubble.fill")
                }
            
            ProfileScreen()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                }
            
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
