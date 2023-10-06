//
//  ResponseInfo.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 3/10/23.
//

import Foundation

struct ResponseInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
