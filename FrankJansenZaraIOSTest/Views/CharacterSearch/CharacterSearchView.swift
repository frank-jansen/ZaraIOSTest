//
//  CharacterSearchView.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 14/3/10/23.
//

import SwiftUI

struct CharacterSearchView: View {
    @State var displayMode = true
    @StateObject var characterListViewModel = CharacterListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ActionButonView(toggleDisplayMode: $displayMode)
                    .environmentObject(characterListViewModel)
                if displayMode {
                    CharacterListView()
                        .environmentObject(characterListViewModel)
                } else {
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
