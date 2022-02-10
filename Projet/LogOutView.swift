//
//  LogOutView.swift
//  Projet
//
//  Created by Joris on 09/02/2022.
//

import SwiftUI

struct LogOutView: View {
    @EnvironmentObject var model: ViewModel
    var body: some View {
        VStack{
            if let _ = model.user{
                Button("Se déconnecter", action: {
                    model.logout()
                })
                    .foregroundColor(.orange)
                    .padding()
                    .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.orange, lineWidth: 3)
                            )
            }
            else {
                Text("Vous n'êtes pas connecté.")
                    .fontWeight(.black)
                    .foregroundColor(Color.red)
            }
        }
        .padding()
    }
}

struct LogOutView_Previews: PreviewProvider {
    static var previews: some View {
        LogOutView()
    }
}

