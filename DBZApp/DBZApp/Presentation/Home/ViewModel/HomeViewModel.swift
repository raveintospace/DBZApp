//
//  HomeViewModel.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    
    // MARK: - Character data
    @Published private(set) var characters: [Character] = []
    @Published private(set) var filteredCharacters: [Character] = []
    
    // MARK: - Search & filtering characters
    @Published var searchText: String = ""
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    // MARK: - Filters for characters
    @Published var affiliationFilters: [Filter] = []
    @Published var genderFilters: [Filter] = []
    @Published var raceFilters: [Filter] = []
    
    // MARK: - Loading states and error handling
    @Published var isLoading: Bool = false
    @Published var error: UseCaseError?
    
    // MARK: - Use Cases
    private let getLocalCharactersUseCase: GetLocalCharactersUseCaseProtocol
    private let fetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCaseProtocol
    private let getFiltersUseCase: GetFiltersUseCaseProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getLocalCharactersUseCase: GetLocalCharactersUseCaseProtocol,
        fetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCaseProtocol,
        getFiltersUseCase: GetFiltersUseCaseProtocol
    ) {
        self.getLocalCharactersUseCase = getLocalCharactersUseCase
        self.fetchCharactersFromAPIUseCase = fetchCharactersFromAPIUseCase
        self.getFiltersUseCase = getFiltersUseCase
        
        addSubscribers()
        
        Task {
            await loadAffiliationFilters()
        }
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
    
    // MARK: - Loading filters
    func loadAffiliationFilters() async {
        do {
            self.affiliationFilters = try await getFiltersUseCase.executeAffiliationFilters()
        } catch {
            debugPrint("Failed to load affiliation filters: \(error)")
        }
    }
    
    func loadGenderFilters() async {
        do {
            self.genderFilters = try await getFiltersUseCase.executeGenderFilters()
        } catch {
            debugPrint("Failed to load gender filters: \(error)")
        }
    }
    
    func loadRaceFilters() async {
        do {
            self.raceFilters = try await getFiltersUseCase.executeRaceFilters()
        } catch {
            debugPrint("Failed to load race filters: \(error)")
        }
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
