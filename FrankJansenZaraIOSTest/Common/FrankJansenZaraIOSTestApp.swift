//
//  FrankJansenZaraIOSTestApp.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 1/10/23.
//

import SwiftUI

@main
struct FrankJansenZaraIOSTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    URLCache.shared.memoryCapacity = 50_000_000 // ~50 MB memory space
                    URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space
                }
        }
    }
}
