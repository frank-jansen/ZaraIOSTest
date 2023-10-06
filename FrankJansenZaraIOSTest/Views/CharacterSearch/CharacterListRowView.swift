//
//  CharacterListRowView.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 3/10/23.
//

import SwiftUI

struct CharacterListRowView: View {
    @EnvironmentObject var characterListViewModel: CharacterListViewModel
    let index: Int
    let character: Character
    var body: some View {
        Text(character.name)
            .font(.custom("American Typewriter", size: 28))
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .padding()
            .foregroundColor(.white)
            .shadow(color: .black, radius: 3)
            .onAppear {
                Task {
                    await characterListViewModel.requestMoreItemsIfNeeded(index: index)
                }
            }
    }
}

struct MainViewListRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListRowView(index: 1, character: Response<Character>.mock.results.first!)
    }
}
