//
//  Service.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 9/3/10/23.
//

import Foundation

protocol Service {
    var base: String { get }
    var path: String { get }
    var method: HttpMethod { get }
}

extension Service {
    var fullPath: String { base + path }
    var url: URL? { .init(service: self) }
}
enum HttpMethod: String {
    case get = "GET"
}
extension URL {
    
    init?(service: Service) {
       self.init(string: service.fullPath)
    }
    
}
