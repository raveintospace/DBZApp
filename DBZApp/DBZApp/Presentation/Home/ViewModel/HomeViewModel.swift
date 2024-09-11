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
    
    var displayedCharacters: [Character] {
        if isSearching || !filteredCharacters.isEmpty {
            return filteredCharacters
        } else {
            return characters
        }
    }
    
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
        
        // Search filtering
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
        
        // Filter application
        if let filter = selectedFilter {
            filtered = applyFilter(filter: filter, characters: filtered)
        }
        
        // Set filtered characters
        print("Filtered characters count: \(filtered.count)")
        filteredCharacters = filtered
    }
    
    // MARK: - Filter logic for Filters
    private func applyFilter(filter: Filter, characters: [Character]) -> [Character] {
        let filterTitle = filter.title.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        return characters.filter { character in
            let affiliationMatch = character.affiliation.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == filterTitle
            let genderMatch = character.gender.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == filterTitle
            let raceMatch = character.race.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == filterTitle

            switch filter.title.lowercased() {
            case "army of frieza", "assistant of beerus", "assistant of vermoud", "freelancer", "namekian warrior", "other", "pride troopers", "red ribbon army", "villain", "z fighter":
                return affiliationMatch
            case "female", "male", "other", "unknown":
                return genderMatch
            case "android", "angel", "benign nucleic", "evil", "frieza race", "god", "human", "jiren race", "majin", "namekian", "nucleic", "saiyan", "unknown":
                return raceMatch
            default:
                return false
            }
        }
    }
}
