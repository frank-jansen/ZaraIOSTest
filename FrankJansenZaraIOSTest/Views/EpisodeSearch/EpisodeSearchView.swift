//
//  EpisodeSearchView.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 10/3/10/23.
//

import SwiftUI


struct EpisodeSearchView: View {
    @StateObject var episodeListViewModel = EpisodeListViewModel()
    @StateObject var characterListViewModel = CharacterListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack{
                SearchBar(searched: $episodeListViewModel.searchEpisode)
                List {
                    ForEach(0..<episodeListViewModel.episodeResults.count, id: \.self) { index in
                        let episode = episodeListViewModel.episodeResults[index]
                        NavigationLink(value: episode) {
                            SearchListItems(episode: episode)
                                .onAppear {
                                    Task {
                                        await episodeListViewModel.requestMoreEpisodesIfNeeded(index: index)
                                    }
                                }
                        }
                        .listRowBackground(Color(.clear))
                        .listRowSeparator(.hidden)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .strokeBorder(.white)
                                Color.black
                                    .opacity(0.6)
                            }
                        )
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .background(
                Image("Wallpaper")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            .navigationDestination(for: Character.self) { value in
                CharacterDetailView(character: value)
            }
            .navigationDestination(for: Episode.self) { value in
                EpisodeDetailedVew(episode: value)
                    .environmentObject(episodeListViewModel)
                    .environmentObject(characterListViewModel)
            }
            .navigationTitle("List of Episodes")
            .navigationBarTitleDisplayMode(.inline)
//            .toolbarTitleMenu {
                
//            }
        }
        .alert("Error", isPresented: $episodeListViewModel.showError) {
            Button("accept") {
                episodeListViewModel.showError = false
            }
        } message: {
            Text(episodeListViewModel.errorMessage ?? "")
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

struct EpisodeListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeSearchView()
    }
}
