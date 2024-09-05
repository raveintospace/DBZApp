//
//  HomeViewModel.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var error: UseCaseError?
    
    private let getLocalCharactersUseCase: GetLocalCharactersUseCaseProtocol
    private let fetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCaseProtocol
    
    init(
        getLocalCharactersUseCase: GetLocalCharactersUseCaseProtocol,
        fetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCaseProtocol
    ) {
        self.getLocalCharactersUseCase = getLocalCharactersUseCase
        self.fetchCharactersFromAPIUseCase = fetchCharactersFromAPIUseCase
    }
    
    func loadLocalCharacters() async {
        guard characters.isEmpty else { return }
        
        isLoading = true
        
        do {
            self.characters = await getLocalCharactersUseCase.execute()
            self.error = nil
        } catch {
            self.error = .undefinedError
        }
        isLoading = false
    }
    
    func fetchCharactersFromAPI() async {
        isLoading = true
        
        do {
            self.characters = await fetchCharactersFromAPIUseCase.execute()
            self.error = nil
        } catch {
            self.error = .undefinedError
        }
        
        isLoading = false
    }
}
