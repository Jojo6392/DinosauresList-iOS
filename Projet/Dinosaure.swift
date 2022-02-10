//
//  Dinosaure.swift
//  Projet
//
//  Created by Joris on 10/02/2022.
//

import Foundation
import FirebaseFirestoreSwift

class Dinosaure: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String?
    var date: Int?
    var description: String?
    var epoque: String?
    var isCarnivore: Bool?
    var lieu: String?
    var poids: String?
    var taille: String?
}
