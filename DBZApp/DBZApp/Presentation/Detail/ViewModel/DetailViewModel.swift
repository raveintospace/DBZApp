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
    @Published var error: UseCaseError?
    
    private let fetchDetailCharacterUseCase: FetchDetailCharacterUseCaseProtocol
    
    init(character: Character, fetchDetailCharacterUseCase: FetchDetailCharacterUseCaseProtocol) {
        self.character = character
        self.fetchDetailCharacterUseCase = fetchDetailCharacterUseCase
    }
    
    func fetchCharacterDetails(id: Int) async {
        isLoading = true
        error = nil
        let startTime = Date()
        
        do {
            let detailedCharacterFromApi = try await fetchDetailCharacterUseCase.execute(id: id)
            detailedCharacter = detailedCharacterFromApi
        } catch {
            self.error = .undefinedError
            debugPrint("Error loading character details")
        }
        
        let elapsedTime = Date().timeIntervalSince(startTime)
        
        // Pause removing ProgressColorBarsView if data is loaded fast, to have a smooth transition to expected view
        if elapsedTime < 0.5 {
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        }
        
        isLoading = false
    }
}
