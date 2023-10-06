//
//  FrankJansenZaraIOSTestTests.swift
//  FrankJansenZaraIOSTestTests
//
//  Created by Frank Jansen on 1/10/23.
//

import XCTest

final class FrankJansenZaraIOSTestTests: XCTestCase {

    func testJSONParsing() throws {
        //Given
        let bundle = Bundle(for: type(of: self))
        let url = try XCTUnwrap(bundle.url(forResource: "AllCharactersResponse", withExtension: "json"))
        let data = try Data(contentsOf: url)
        //When
        let response = try JSONDecoder().decode(Response<Character>.self, from: data)
        //Then
        XCTAssertEqual(response.results.count, 20)
    }
}
