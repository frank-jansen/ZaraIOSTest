//
//  CharacterGridView.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 7/3/10/23.
//

import SwiftUI

struct CharacterGridView: View {
    @EnvironmentObject var characterListViewModel: CharacterListViewModel
    @State var selectedCharacter: Character?
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 40)),
                GridItem(.flexible(minimum: 40)),
                GridItem(.flexible(minimum: 40))
            ], content: {
                ForEach(characterListViewModel.results.indices, id: \.self) { index in
                    let character = characterListViewModel.results[index]
                    GridItemView(character: character)
                        .padding()
                        .onTapGesture {
                            selectedCharacter = character
                        }
                        .onAppear {
                            Task {
                                await characterListViewModel.requestMoreItemsIfNeeded(index: index)
                            }
                        }
                }
                
                .sheet(item: $selectedCharacter) { character in
                    CharacterDetailView(character: character)
                        .background (
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.clear.opacity(0.8))
                                .shadow(color:.cyan ,radius: 50)
                            
                        )
                }
            }
                      
            )
            
        }
            .background(.clear.opacity(0.8))
        
    }
}

struct CharacterGridView_Previews: PreviewProvider {
    @State static var selectedCharacter: Character? = nil
    static var previews: some View {
        CharacterGridView(selectedCharacter: selectedCharacter ?? Response.self.mock.results.last!).environmentObject(CharacterListViewModel())
    }
}
