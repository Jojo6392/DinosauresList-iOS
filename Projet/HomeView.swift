//
//  HomeView.swift
//  Projet
//
//  Created by Joris on 09/02/2022.
//

import SwiftUI


struct HomeView: View {
    @EnvironmentObject var model: ViewModel
    @State var showForm = false

    var body: some View {
        VStack{
            if let _ = model.user{
                
                NavigationView {
                    List {
                        ForEach(model.dinosaures, id: \.id) { dinosaure in
                            
                            NavigationLink(
                                destination: DinosaureView(
                                    data: dinosaure
                                )
                            ) {
                                HStack {
                                    let name = dinosaure.name ?? "No name"
                                    Text("\(name)")
                                        .padding()
                                }
                            }.navigationTitle("Dinosaures")
                        }
                        .onDelete {indexSet in
                            self.model.deleteDinosaure(at: indexSet)}
                    }
                    .toolbar {
                        Button {
                            showForm = true
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                
            } else {
                LoginView()
            }
            
            if let errorMessage = model.errorMessage{
                Text(errorMessage)
                    .padding()
                    .foregroundColor(.red)
            }
        }
        .sheet(isPresented: $showForm) {
            FormView(showForm: $showForm)
        }
        .padding()
    }
}

struct FormView: View {
    @Binding var showForm: Bool
    
    @EnvironmentObject var model: ViewModel
    @State private var name: String = ""
    @State private var date: String = ""
    @State private var epoque: String = ""
    @State private var lieu: String = ""
    @State private var poids: String = ""
    @State private var taille: String = ""
    @State private var isCarnivore: Bool = false
    @State private var description: String = ""
    
    var body: some View {
        VStack {
            Text("Ajouter un dinosaure")
                .font(.title)
                .foregroundColor(Color.orange)
                .padding()
            
            TextField("Nom", text: $name)
                .padding()
                .textFieldStyle(.roundedBorder)
            
            HStack {
                TextField("Date de découverte", text: $date)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                TextField("Epoque", text: $epoque)
                    .padding()
                    .textFieldStyle(.roundedBorder)
            }
        
            TextField("Lieu", text: $lieu)
                .padding()
                .textFieldStyle(.roundedBorder)
            
            HStack {
                TextField("Poids", text: $poids)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                TextField("Taille", text: $taille)
                    .padding()
                    .textFieldStyle(.roundedBorder)
            }
            
            NavigationView {
                Toggle("Est-il carnivore ?", isOn: $isCarnivore)
                    .padding()
                    .textFieldStyle(.roundedBorder)
            }
            
            TextEditor(text: $description)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.orange, lineWidth: 3)
                )

            Button("Créer",action: {
                showForm = false
                model.addDinosaure(name: name, date: date, description: description, epoque: epoque, isCarnivore: isCarnivore, lieu: lieu, poids: poids, taille: taille)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

