//
//  ContentView.swift
//  Projet
//
//  Created by Joris on 09/02/2022.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @StateObject var model = ViewModel()
    
    var body: some View {
        VStack{
            TabView {
                
                if let _ = model.user {
                    HomeView()
                        .tabItem {
                            Label("Dinosaures", systemImage: "leaf.fill")
                        }
                    
                    LogOutView()
                        .tabItem {
                            Label("Se déconnecter", systemImage: "person.fill.badge.minus")
                        }
                    }
                else {
                    HomeView()
                        .tabItem {
                            Label("Se connecter", systemImage: "person.fill")
                        }

                }
                }
                
            }.environmentObject(model)
        }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
