//
//  CharacterService.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 9/3/10/23.
//

import Foundation

enum CharacterService {
    case paged(page: String)
    case filtered(queryFilter: QueryFilter)
}

extension CharacterService: Service {
    var base: String {
        switch self {
        case let .paged(page): return page
        default: return "https://rickandmortyapi.com/api/character"
        }
    }
    
    var path: String {
        var components = URLComponents()
        switch self {
        case let .filtered(queryFilter):
            components.queryItems = [
                URLQueryItem(name: "status", value: queryFilter.status),
                URLQueryItem(name: "gender", value: queryFilter.gender),
                URLQueryItem(name: "name", value: queryFilter.name),
                
                         ]
        default: break
        }
        return components.string ?? ""
    }
    
    var method: HttpMethod { .get }
}

struct QueryFilter {
    var name: String
    var status: String
    var gender: String
}
