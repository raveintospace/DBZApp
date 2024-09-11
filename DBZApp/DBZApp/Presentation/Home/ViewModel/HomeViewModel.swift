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
    @Published var selectedFilter: Filter? = nil
    
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
            .combineLatest($selectedFilter)
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] (searchText, selectedFilter) in
                guard let self = self else { return }
                self.filterCharacters(searchText: searchText, selectedFilter: selectedFilter)
            }
            .store(in: &cancellables)
    }
    
    private func filterCharacters(searchText: String, selectedFilter: Filter?) {
        var filtered = characters
        
        if !searchText.isEmpty {
            let search = searchText.lowercased()
            filtered = filtered.filter { character in
                let nameContainsSearch = character.name.lowercased().contains(search)
                let descriptionContainsSearch = character.description.lowercased().contains(search)
                let affiliationContainsSearch = character.affiliation.lowercased().contains(search)
                let genderContainsSearch = character.gender.lowercased().contains(search)
                let raceContainsSearch = character.race.lowercased().contains(search)
                return nameContainsSearch || descriptionContainsSearch || affiliationContainsSearch || genderContainsSearch || raceContainsSearch
            }
        }
        
        if let filter = selectedFilter {
            filtered = applyFilter(filter: filter, characters: filtered)
        }
        
        filteredCharacters = filtered
    }
    
    // MARK: - Filter logic for Filters
    private func applyFilter(filter: Filter, characters: [Character]) -> [Character] {
        switch filter.title {
        case "Army of Frieza", "Assistant of Beerus", "Assistant of Vermoud", "Freelancer", "Namekian Warrior", "Other", "Pride Troopers", "Red Ribbon Army", "Villain", "Z Fighter":
            return characters.filter { $0.affiliation == filter.title }
        case "Female", "Male", "Other", "Unknown":
            return characters.filter { $0.gender == filter.title }
        case "Android", "Angel", "Benign Nucleic", "Evil", "Frieza Race", "God", "Human", "Jiren Race", "Majin", "Namekian", "Nucleic", "Saiyan", "Unknown":
            return characters.filter { $0.race == filter.title }
        default:
            return characters
        }
    }
}
