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
        guard detailedCharacter == nil else { return }
        
        isLoading = true
        let startTime = Date()
        
        do {
            self.detailedCharacter = try await fetchDetailCharacterUseCase.execute(id: id)
            self.error = nil
        } catch {
            self.error = .undefinedError
            debugPrint("Error loading character details")
        }
        
        await pauseForSmoothTransition(startTime: startTime)
        
        isLoading = false
    }
    
    // MARK: - Transition from progress view to expected final view
    private func pauseForSmoothTransition(startTime: Date, minDuration: TimeInterval = 0.5) async {
        let elapsedTime = Date().timeIntervalSince(startTime)
        
        // Ensure a 0.5 second pause
        if elapsedTime < minDuration {
            let remainingTime = minDuration - elapsedTime
            try? await Task.sleep(nanoseconds: UInt64(remainingTime * 1_000_000_000))
        }
    }
    
    // MARK: - Logic to show transformation button
    func hasTransformations() -> Bool {
        guard let detailedCharacter = detailedCharacter else { return false }
        return !detailedCharacter.transformations.isEmpty
    }
}
