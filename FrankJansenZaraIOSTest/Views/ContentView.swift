//
//  ContentView.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 1/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var displayMode = true
    var body: some View {
        TabView {
            CharacterSearchView()
                .tabItem {
                    Label("Characters", systemImage: "person.fill.viewfinder")
                }
                .toolbarBackground(.black , for: .tabBar)
            
            EpisodeSearchView()
                .tabItem {
                    Label("Episodes", systemImage: "globe.europe.africa")
                }
                .toolbarBackground(.black , for: .tabBar)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
