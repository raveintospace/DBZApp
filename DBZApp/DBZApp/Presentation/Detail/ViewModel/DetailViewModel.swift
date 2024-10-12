//
//  DetailViewModel.swift
//  DBZApp
//
//  Created by Uri on 6/10/24.
//

import Foundation

@MainActor
final class DetailViewModel: ObservableObject {
    
    @Published var character: Character
    @Published var detailedCharacter: DetailedCharacter?
    @Published var isLoading: Bool = false
    @Published var errorMessage: UseCaseError?
    
    private let fetchDetailCharacterUseCase: FetchDetailCharacterUseCaseProtocol
    
    init(character: Character, fetchDetailCharacterUseCase: FetchDetailCharacterUseCaseProtocol) {
        self.character = character
        self.fetchDetailCharacterUseCase = fetchDetailCharacterUseCase
    }
    
    func fetchCharacterDetails(id: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let detailedCharacterFromApi = try await fetchDetailCharacterUseCase.execute(id: id)
            detailedCharacter = detailedCharacterFromApi
        } catch {
            errorMessage = .undefinedError
            debugPrint("Error loading character details")
        }
        
        isLoading = false
    }
}
