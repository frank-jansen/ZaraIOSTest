//
//  CharacterSearchView.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 14/3/10/23.
//

import SwiftUI

struct CharacterSearchView: View {
    @StateObject var characterListViewModel = CharacterListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ActionButtonView()
                    .environmentObject(characterListViewModel)
                
                switch characterListViewModel.displayMode {
                case .list:
                    CharacterListView()
                        .environmentObject(characterListViewModel)
                case .grid:
                    CharacterGridView()
                        .environmentObject(characterListViewModel)
                }
                Spacer()
            }
            .background {                
                ZStack {
                    Image("Wallpaper")
                        .resizable()
                        .scaledToFit()
                        .scaledToFill()
                        .ignoresSafeArea(.all)
                    Color.black
                        .ignoresSafeArea(.all)
                        .opacity(0.1)
                        .blur(radius: 5)
                }
            }
            .navigationDestination(for: Character.self) { value in
                CharacterDetailView(character: value)
            }
        }
        .alert("Error", isPresented: $characterListViewModel.showError) {
            Button("accept") {
                characterListViewModel.showError = false
            }
        } message: {
            Text(characterListViewModel.errorMessage ?? "")
        }
    }
}

struct CharacterSearchView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSearchView().environmentObject(CharacterListViewModel())    }
}
