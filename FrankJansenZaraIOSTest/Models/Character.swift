//
//  Character.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 1/10/23.
//

import Foundation
import SwiftUI

struct Character: Decodable, Identifiable, Hashable {
    
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
}

extension Character {
    enum Status: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown
        
        var color: Color {
            switch self {
            case .alive: return .green
            case .dead: return .gray
            case .unknown: return .yellow
            }
        }
    }
    
    enum Gender: String, Decodable {
        case male = "Male"
        case female = "Female"
        case genderless = "Genderless"
        case unknown
    }
}
