//
//  Response.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 3/10/23.
//

import Foundation

struct Response<T:Decodable>: Decodable {
    let info: ResponseInfo
    let results: [T]
}
