//
//  LoginView.swift
//  Projet
//
//  Created by Joris on 09/02/2022.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var model: ViewModel
    @State private var mail: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
                
            Text("Connexion")
                .font(.title)
                .foregroundColor(Color.orange)
                .padding()
                
            
            TextField("Adresse mail", text: $mail)
                .padding()
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            SecureField("Mot de passe", text: $password)
                .padding()
                .textFieldStyle(.roundedBorder)
            
            Button("Se connecter",action: {
                model.login(mail: mail, password: password)
            })
                .padding()
                .frame(alignment: .center)
                .foregroundColor(.orange)
                .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.orange, lineWidth: 3)
                        )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
