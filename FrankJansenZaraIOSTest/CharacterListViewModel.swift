//
//  CharacterListViewModel.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 3/10/23.
//

import Foundation
import Combine

class CharacterListViewModel: APIRequestable, ObservableObject  {
    
    @Published var results = [Character]()
    @Published var dataIsLoading = false
    @Published var errorMessage : String?
    @Published var showError = false
    
    @Published var search: String = ""
    @Published var status: Character.Status?
    @Published var gender: Character.Gender?
    
    
    private let itemsPaginationThreshold = 20
    
    private var responseInfo: ResponseInfo?
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        Publishers.CombineLatest3($search.removeDuplicates(),
                                  $status.removeDuplicates(),
                                  $gender.removeDuplicates())
        .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
        .sink { _ in
            Task { [weak self] in
                await self?.loadData(page: nil)
            }
        }
        .store(in: &self.cancellables)
    }
    
    @MainActor
    private func loadData(page: String?) async {
        guard !dataIsLoading else { return }
        
        do {
            dataIsLoading = true
            let service: CharacterService
            if let page = page {
                service = .paged(page: page)
            } else {
                service = .filtered(queryFilter: .init(name: search,
                                                       status: status?.rawValue ?? "",
                                                       gender: gender?.rawValue ?? ""))
            }
            
            let response = try await request(service: service,
                                             modelType: Response<Character>.self)
            
            if page != nil {
                results.append(contentsOf: response.results)
            } else {
                results = response.results
            }
            responseInfo = response.info
            errorMessage = nil
            dataIsLoading = false
        } catch {
            dataIsLoading = false
            showError = true
            errorMessage = error.localizedDescription
        }
    }
    
    func requestMoreItemsIfNeeded(index: Int) async {
        guard let responseInfo = responseInfo else {
            return
        }
        
        let loaded = results.count
        
        // si el indice actual es el ultimo del treshhold y aun me falta cargar mas
        if let next = responseInfo.next,
           (loaded - index) == itemsPaginationThreshold &&
            loaded < responseInfo.count {
            // Request next page
            await loadData(page: next)
        }
    }
    
}
