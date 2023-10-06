//
//  EpisodeService.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 14/3/10/23.
//

import Foundation

enum EpisodeService {
    case paged(page: String)
    case filtered(name: String, episode: Int)
}

extension EpisodeService: Service {
    var base: String {
        switch self {
        case let .paged(page): return page
        default: return "https://rickandmortyapi.com/api/episode"
        }
    }
    
    var path: String {
        var components = URLComponents()
        switch self {
        case let .filtered(name,episode):
            components.queryItems = [
                URLQueryItem(name: "name", value: name),
                URLQueryItem(name: "episode", value: "\(episode)")
                         ]
        default: break
        }
        return components.string ?? ""
    }
    
    var method: HttpMethod { .get }
}

//struct QueryFilter {
//    var name: String
//    var status: String
//    var gender: String
//}
