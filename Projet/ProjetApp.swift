//
//  ProjetApp.swift
//  Projet
//
//  Created by Joris on 09/02/2022.
//

import SwiftUI
import Firebase

@main
struct ProjetApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
