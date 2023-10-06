//
//  Episode.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 14/3/10/23.
//

import Foundation

struct Episode: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let air_date: String?
    let episode: String
    let characters: [String]?
    let url: String
    let created: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        lhs.id == rhs.id
    }
}

