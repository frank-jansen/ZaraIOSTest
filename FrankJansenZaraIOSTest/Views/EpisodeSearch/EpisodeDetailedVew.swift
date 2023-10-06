//
//  EpisodeDetailedVew.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 17/3/10/23.
//

import SwiftUI

struct EpisodeDetailedVew: View {
    
    @EnvironmentObject var episodeListviewModel: EpisodeListViewModel
    @EnvironmentObject var characterViewModel: CharacterListViewModel
    let episode: Episode
    
    var body: some View {
        CharacterListView()
            .onAppear {
                Task {
                    await episodeListviewModel.loadCharactersListfromEpisodes(urls: episode.characters)
                }
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
            .navigationTitle("List of Characters")
            .navigationBarTitleDisplayMode(.inline)        
    }
}

struct EpisodeDetailedVew_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailedVew(episode: Response.mock2.results.first!)
            .environmentObject(EpisodeListViewModel())
            .environmentObject(CharacterListViewModel())
    }
}
