//
//  CharacterListView.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 3/10/23.
//

import SwiftUI

struct CharacterListView: View {
    @EnvironmentObject var characterListViewModel: CharacterListViewModel
    
    var body: some View {
        if characterListViewModel.results.isEmpty {
            Text("No results")
                .foregroundColor(.red)
        } else {
            List {
                ForEach(0..<characterListViewModel.results.count, id: \.self) { index in
                    let character = characterListViewModel.results[index]
                    NavigationLink(value: character) {
                        CharacterListRowView(index: index, character: character)
                            .environmentObject(characterListViewModel)
                    }
                    .listRowBackground(Color(.clear))
                    .listRowSeparator(.hidden)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(character.status.color)
                            character.status.color
                                .opacity(0.4)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                    )
                }
            }
            .scrollContentBackground(.hidden)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
            .environmentObject(CharacterListViewModel())
    }
}
