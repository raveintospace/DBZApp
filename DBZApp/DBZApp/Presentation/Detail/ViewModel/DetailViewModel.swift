//
//  DetailViewModel.swift
//  DBZApp
//
//  Created by Uri on 6/10/24.
//

import Foundation

@MainActor
final class DetailViewModel: ObservableObject {
    @Published var detailedCharacter: DetailedCharacter?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let fetchDetailCharacterUseCase: FetchDetailCharacterUseCaseProtocol
    
    init(fetchDetailCharacterUseCase: FetchDetailCharacterUseCaseProtocol) {
        self.fetchDetailCharacterUseCase = fetchDetailCharacterUseCase
    }
    
    func fetchCharacterDetails(id: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let character = try await fetchDetailCharacterUseCase.execute(id: id)
            detailedCharacter = character
        } catch {
            errorMessage = "Failed to load character details."
            debugPrint("Error loading character details: \(error)")
        }
        
        isLoading = false
    }
}
