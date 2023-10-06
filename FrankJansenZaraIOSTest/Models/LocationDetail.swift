//
//  LocationDetail.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 3/10/23.
//

import Foundation

struct LocationDetail: Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let resident: String
    let url: String
    let created: String
}
