//
//  Make_It_WorkApp.swift
//  Make It Work
//
//  Created by Khalid Thomas on 2/2/23.
//

import SwiftUI
import Firebase

class AppState: ObservableObject{
    
    @Published var hasOnboarded: Bool
    
    init(hasOnboarded: Bool) {
        self.hasOnboarded = hasOnboarded
    }
}


@main

struct Make_It_WorkApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject var appState = AppState(hasOnboarded: false)
    
    var body: some Scene {
        WindowGroup {
            if appState.hasOnboarded {
                HomeView()
                    .environmentObject(appState)
            } else {
                ContentView()
                    .environmentObject(appState)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
