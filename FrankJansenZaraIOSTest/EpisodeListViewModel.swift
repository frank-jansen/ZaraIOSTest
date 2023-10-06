//
//  EpisodeListViewModel.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 4/3/10/23.
//

import Foundation
import Combine

class EpisodeListViewModel:APIRequestable, ObservableObject {
    
    @Published var listOfCharacters = [Character]()
    @Published var episodeResults = [Episode]()
    @Published var errorMessage : String?
    @Published var search: String = ""
    @Published var showError = false
    
    @Published var searchEpisode: String = ""
    @Published var episodeNumber: Int = 0
    
    @Published var episodesAreLoading = false
    
    private var responseInfo: ResponseInfo?
    private var cancellables = Set<AnyCancellable>()
    private let itemsPaginationThreshold = 20
    
    override init() {
        super.init()
        Publishers.CombineLatest($searchEpisode.removeDuplicates(),
                                 $episodeNumber.removeDuplicates())
        .sink {_ in
            Task { [weak self] in
                await self?.loadEpisodeData(page: nil)
            }
        }
        .store(in: &self.cancellables)
    }
    
    @MainActor
    private func loadEpisodeData(page: String?) async {
        guard !episodesAreLoading else { return }
        
        do {
            episodesAreLoading = true
            let service: EpisodeService
            if let page = page {
                service = .paged(page: page)
            } else {
                service = .filtered(name: searchEpisode, episode: episodeNumber)
            }
            
            let response = try await request(service: service,
                                             modelType: Response<Episode>.self)
            
            if page != nil {
                episodeResults.append(contentsOf: response.results)
            } else {
                episodeResults = response.results
            }
            responseInfo = response.info
            errorMessage = nil
            episodesAreLoading = false
        } catch {
            showError = true
            episodesAreLoading = false
            errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    func loadCharactersListfromEpisodes(urls: [String]?) async {
        
        errorMessage = nil
        listOfCharacters = []
        
        do {
            
            listOfCharacters = try await withThrowingTaskGroup(of: Character.self, returning: [Character].self) { taskGroup in
                guard let urls = urls?.compactMap({ URL(string: $0)}) else { return [] }
                
                for url in urls {
                    taskGroup.addTask {
                        let (data, _) = try await URLSession.shared.data(from: url)
                        return try JSONDecoder().decode(Character.self, from: data)
                    }
                    
                }
                
                
                
                var characters = [Character]()
                for try await result in taskGroup {
                    characters.append(result)
                }
                return characters
            }
        } catch {
            showError = true
            errorMessage = error.localizedDescription
        }
    }
    
    func requestMoreEpisodesIfNeeded(index: Int) async {
        guard let responseInfo = responseInfo else {
            return
        }
        let loaded = episodeResults.count
        
        // si el indice actual es el ultimo del treshhold y aun me falta cargar mas
        if let next = responseInfo.next,
           (loaded - index) == itemsPaginationThreshold &&
            loaded < responseInfo.count {
            // Request next page
            await loadEpisodeData(page: next)
        }
    }
}
