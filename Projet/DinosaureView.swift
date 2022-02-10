//
//  DinosaureView.swift
//  Projet
//
//  Created by Joris on 10/02/2022.
//

import SwiftUI
import MapKit
import CoreLocation

struct DinosaureView: View {
    let data: Dinosaure
    
    var body: some View {
        
        let name = data.name ?? "NaN"
        let date = data.date ?? 0
        let description = data.description ?? "NaN"
        let epoque = data.epoque ?? "Pas d'époque"
        let isCarnivore = data.isCarnivore ?? false
        let lieu = data.lieu ?? "NaN"
        let poids = data.poids ?? "NaN"
        let taille = data.taille ?? "NaN"
        
        VStack {
            HStack {
                if isCarnivore == true {
                    Image("carnivore")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                }
                else {
                    Image("herbivore")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                }
                
                Text(name)
                    .font(.title)
                    .foregroundColor(Color.orange)
                    .multilineTextAlignment(.center)
            }
            VStack {
                HStack {
                    
                    Text(epoque)
                        .fontWeight(.bold)
                        .padding()
                    
                    Text(lieu)
                        .fontWeight(.bold)
                        .padding()
                    
                }
                
                Text("Date de découverte : \(String(date))")
                
            }
            .padding(.bottom)
            
            Text("Poids : \(poids)")
            
            Text("Taille : \(taille)")
            Rectangle()
                .stroke(Color.orange, lineWidth: 4)
                .overlay(
                    ScrollView(.vertical) {
                        Text(description)
                            .multilineTextAlignment(.center)
                            .padding()
                            
                    }
                )
        }
            
    }
}

struct DinosaureView_Previews: PreviewProvider {
    
    static var previews: some View {
        DinosaureView(data: Dinosaure())
    }
}
