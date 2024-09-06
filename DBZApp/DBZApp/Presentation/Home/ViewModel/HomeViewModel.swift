//
//  HomeViewModel.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published private(set) var characters: [Character] = []
    
    @Published private(set) var filteredCharacters: [Character] = []
    @Published var searchText: String = ""
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    @Published var isLoading: Bool = false
    @Published var error: UseCaseError?
    
    private let getLocalCharactersUseCase: GetLocalCharactersUseCaseProtocol
    private let fetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCaseProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getLocalCharactersUseCase: GetLocalCharactersUseCaseProtocol,
        fetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCaseProtocol
    ) {
        self.getLocalCharactersUseCase = getLocalCharactersUseCase
        self.fetchCharactersFromAPIUseCase = fetchCharactersFromAPIUseCase
        addSubscribers()
    }
    
    // MARK: - Loading data logic
    func loadLocalCharacters() async {
        guard characters.isEmpty else { return }
        
        isLoading = true
        
        do {
            self.characters = try await getLocalCharactersUseCase.execute()
            self.error = nil
        } catch {
            self.error = .undefinedError
        }
        isLoading = false
    }
    
    func fetchCharactersFromAPI() async {
        isLoading = true
        
        do {
            self.characters = try await fetchCharactersFromAPIUseCase.execute()
            self.error = nil
        } catch {
            self.error = .undefinedError
        }
        
        isLoading = false
    }
    
    // MARK: - Filter logic for searchbar
    private func addSubscribers() {
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                guard let self = self else { return }
                self.filterCharacters(searchText: searchText)
            }
            .store(in: &cancellables)
    }
    
    private func filterCharacters(searchText: String) {
        guard !searchText.isEmpty else {
            filteredCharacters = []
            return
        }
        
        let search = searchText.lowercased()
        filteredCharacters = characters.filter({ character in
            let nameContainsSearch = character.name.lowercased().contains(search)
            let descriptionContainsSearch = character.description.lowercased().contains(search)
            let raceContainsSearch = character.race.lowercased().contains(search)
            let affiliationContainsSearch = character.affiliation.lowercased().contains(search)
            return nameContainsSearch || descriptionContainsSearch || raceContainsSearch || affiliationContainsSearch
        })
    }
}
