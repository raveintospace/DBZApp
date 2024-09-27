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
    @Published private(set) var allCharacters: [Character] = []
    @Published private(set) var favoriteCharacters: [Character] = []
    
    
    // MARK: - Logic to display characters in View
    @Published var showFavorites: Bool = false
    
    var displayedCharacters: [Character] {
        let charactersToFilter: [Character]
        
        if showFavorites {
            charactersToFilter = favoriteCharacters
        } else {
            charactersToFilter = allCharacters
        }

        return sortCharacters(characters: filterCharacters(searchText: searchText, selectedFilter: selectedFilter, characters: charactersToFilter))
    }
    
    // MARK: - Search & filtering characters
    @Published var searchText: String = ""
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    // MARK: - Computed properties to show noResultsView
    var noResultsForFilter: Bool {
            return displayedCharacters.isEmpty && selectedFilter != nil
        }
    
    var noResultsForSearchText : Bool {
        return displayedCharacters.isEmpty && !searchText.isEmpty
    }
    
    var showNoResultsView: Bool {
        return noResultsForFilter || noResultsForSearchText
    }
    
    // MARK: - Filters for characters
    @Published var affiliationFilters: [Filter] = []
    @Published var genderFilters: [Filter] = []
    @Published var raceFilters: [Filter] = []
    @Published var selectedFilter: Filter? = nil
    @Published var selectedFilterOption: FilterOption = .affiliation {
        didSet {
            if oldValue != selectedFilterOption {
                selectedFilter = nil
            }
        }
    }
    @Published var activeSubfilters: [Filter] = []
    
    // MARK: - Sort Option
    @Published var sortOption: SortOption = .id
    
    // MARK: - Loading states and error handling
    @Published var isLoading: Bool = false
    @Published var error: UseCaseError?
    
    // MARK: - Use Cases
    private let getLocalCharactersUseCase: GetLocalCharactersUseCaseProtocol
    private let fetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCaseProtocol
    private let getFiltersUseCase: GetFiltersUseCaseProtocol
    private let sortCharactersUseCase: SortCharactersUsecaseProtocol
    private let favoritesUseCase: FavoritesUseCaseProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getLocalCharactersUseCase: GetLocalCharactersUseCaseProtocol,
        fetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCaseProtocol,
        getFiltersUseCase: GetFiltersUseCaseProtocol,
        sortCharactersUseCase: SortCharactersUsecaseProtocol,
        favoritesUseCase: FavoritesUseCaseProtocol
    ) {
        self.getLocalCharactersUseCase = getLocalCharactersUseCase
        self.fetchCharactersFromAPIUseCase = fetchCharactersFromAPIUseCase
        self.getFiltersUseCase = getFiltersUseCase
        self.sortCharactersUseCase = sortCharactersUseCase
        self.favoritesUseCase = favoritesUseCase
        
        addSubscribers()
        
        Task {
            await loadAffiliationFilters()
        }
    }
    
    // MARK: - Loading data logic
    func loadLocalCharacters() async {
        guard allCharacters.isEmpty else { return }
        
        isLoading = true
        
        do {
            self.allCharacters = try await getLocalCharactersUseCase.execute()
            self.error = nil
        } catch {
            self.error = .undefinedError
        }
        isLoading = false
    }
    
    func fetchCharactersFromAPI() async {
        guard allCharacters.isEmpty else { return }
        
        isLoading = true
        
        do {
            self.allCharacters = try await fetchCharactersFromAPIUseCase.execute()
            self.error = nil
        } catch {
            self.error = .undefinedError
        }
        
        isLoading = false
    }
    
    // MARK: - Loading filters logic
    func loadAffiliationFilters() async {
        guard affiliationFilters.isEmpty else { return }
        
        do {
            self.affiliationFilters = try await getFiltersUseCase.executeAffiliationFilters()
        } catch {
            debugPrint("Failed to load affiliation filters: \(error)")
        }
    }
    
    func loadGenderFilters() async {
        guard genderFilters.isEmpty else { return }
        
        do {
            self.genderFilters = try await getFiltersUseCase.executeGenderFilters()
        } catch {
            debugPrint("Failed to load gender filters: \(error)")
        }
    }
    
    func loadRaceFilters() async {
        guard raceFilters.isEmpty else { return }
        
        do {
            self.raceFilters = try await getFiltersUseCase.executeRaceFilters()
        } catch {
            debugPrint("Failed to load race filters: \(error)")
        }
    }
    
    func updateActiveSubfilters() async {
        switch selectedFilterOption {
        case .affiliation:
            await loadAffiliationFilters()
            activeSubfilters = affiliationFilters
        case .gender:
            await loadGenderFilters()
            activeSubfilters = genderFilters
        case .race:
            await loadRaceFilters()
            activeSubfilters = raceFilters
        }
    }
    
    // MARK: - Combine subscriptions
    private func addSubscribers() {
        $searchText
            .combineLatest($selectedFilter)
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] (searchText, selectedFilter) in
                guard self != nil else { return }
            }
            .store(in: &cancellables)
        
        $selectedFilterOption
            .sink { [weak self] filterOption in
                guard let self = self else { return }
                Task {
                    await self.updateActiveSubfilters()
                }
            }
            .store(in: &cancellables)
        
        $allCharacters
            .combineLatest(favoritesUseCase.favoritesPublisher)
            .map(mapAllCharactersToFavorites)
            .sink { [weak self] (mappedFavorites) in
                guard let self = self else { return }
                self.favoriteCharacters = mappedFavorites
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Filter logic with searchText & Filters
    private func filterCharacters(searchText: String, selectedFilter: Filter?, characters: [Character]) -> [Character] {
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
        
        // Apply filters
        if let filter = selectedFilter {
            filtered = applyFilter(filter: filter, characters: filtered)
        }
        
        return filtered
    }
    
    // MARK: - Filter logic for Filters
    private func applyFilter(filter: Filter, characters: [Character]) -> [Character] {
        let filterTitle = filter.title.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        return characters.filter { character in
            switch selectedFilterOption {
            case .affiliation:
                return character.affiliation.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == filterTitle
            case .gender:
                return character.gender.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == filterTitle
            case .race:
                return character.race.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == filterTitle
            }
        }
    }
    
    // MARK: - Sort logic
    private func sortCharacters(characters: [Character]) -> [Character] {
        switch sortOption {
        case .id:
            return characters.sorted { $0.id < $1.id }
        case .idReversed:
            return characters.sorted { $0.id > $1.id }
        case .name:
            return characters.sorted { $0.name.localizedCompare($1.name) == .orderedAscending }
        case .nameReversed:
            return characters.sorted { $0.name.localizedCompare($1.name) == .orderedDescending }
        case .kiPoints:
            return characters.sorted {
                let first = sortCharactersUseCase.convertKiPointsToNumber($0.kiToCompare) ?? Decimal(-1)
                let second = sortCharactersUseCase.convertKiPointsToNumber($1.kiToCompare) ?? Decimal(-1)
                return first > second
            }
        case .kiPointsReversed:
            return characters.sorted {
                let first = sortCharactersUseCase.convertKiPointsToNumber($0.kiToCompare) ?? Decimal(-1)
                let second = sortCharactersUseCase.convertKiPointsToNumber($1.kiToCompare) ?? Decimal(-1)
                return first < second
            }
        }
    }
    
    // MARK: - Favorites logic
    private func mapAllCharactersToFavorites(allCharacters: [Character], favoriteEntities: [FavoriteEntity]) -> [Character] {
        allCharacters
            .compactMap { (character) -> Character? in
                guard favoriteEntities.first(where: { $0.characterId == Int64(character.id) }) != nil else {
                    return nil
                }
                return character
            }
    }
    
    func updateFavorites(character: Character) {
        favoritesUseCase.updateFavorite(character: character)
    }
    
    func isNewFav(character: Character) -> Bool {
        if favoriteCharacters.contains(where: { $0.id == character.id }) {
            return true
        } else {
            return false
        }
    }
}
