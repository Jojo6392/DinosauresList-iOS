//
//  ViewModel.swift
//  Projet
//
//  Created by Joris on 09/02/2022.
//

import Foundation
import Combine
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
class ViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var dinosaures = [Dinosaure]()
    @Published var documentsID = []
    
    var listener: ListenerRegistration?
    var subscription: AnyCancellable?
    
    init() {
        subscription = $user.sink(receiveValue: { [weak self] user in
            self?.setListener(user: user)
        })
    }
}


// Firebase management
extension ViewModel {
    func login(mail: String, password: String) {
        Task {
            do {
                let authResult = try await Auth.auth().signIn(withEmail: mail, password: password)
                errorMessage = .none
                user = authResult.user
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            errorMessage = .none
            user = .none
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func snapshotListener(querySnapshot: QuerySnapshot?, error: Error?) {
        if let error = error {
            errorMessage = error.localizedDescription
        }
        
        if let documents = querySnapshot?.documents {
            
            do {
                dinosaures = try documents.compactMap({ document in
                    let dinosaure = try document.data(as: Dinosaure.self)
                    let id = document.documentID
                    documentsID.append(id)
                    
                    return dinosaure
                    
                    
               })
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func setListener(user: User?) {
        if let existingListener = listener {
            existingListener.remove()
            print("Existing listener removed")
            listener = .none
            dinosaures = []
        }

        if let user = user {
            let collection = Firestore.firestore().collection("dinosaures")
            listener = collection.addSnapshotListener { [weak self] (querySnapshot, error) in
                self?.snapshotListener(querySnapshot: querySnapshot, error: error)
            }
            print("Listener added for \(user.uid)")
        }
    }
    
    func addDinosaure(name: String, date: String, description: String, epoque: String, isCarnivore: Bool, lieu: String, poids: String, taille: String) {
        
        let collection = Firestore.firestore().collection("dinosaures")
        let date = Int(date) ?? 0
        collection.document().setData([
            "name": name,
            "date": date,
            "description": description,
            "epoque": epoque,
            "isCarnivore": isCarnivore,
            "lieu": lieu,
            "poids": poids,
            "taille": taille
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func deleteDinosaure(at offsets: IndexSet) {
        offsets.map { dinosaures[$0] }.forEach { dinosaure in
            let dinosaureID = dinosaure.id ?? ""
            let collection = Firestore.firestore().collection("dinosaures")
            collection.document(dinosaureID).delete() { err in
              if let err = err {
                print("Error removing document: \(err)")
              } else {
                print("Document successfully removed!")
              }
            }
          }
    }
}

