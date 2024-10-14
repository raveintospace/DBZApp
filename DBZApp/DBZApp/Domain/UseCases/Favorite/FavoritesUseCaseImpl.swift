//
//  FavoritesUseCaseImpl.swift
//  DBZApp
//
//  Created by Uri on 22/9/24.
//

import Foundation

final class FavoritesUseCaseImpl: FavoritesUseCaseProtocol {
    private let repository: FavoritesRepositoryProtocol
    
    init(repository: FavoritesRepositoryProtocol) {
        self.repository = repository
    }
    
    var favoritesPublisher: Published<[FavoriteEntity]>.Publisher {
        return repository.savedFavorites
    }
    
    func executeUpdateFavorite(character: Character) {
        repository.updateFavorite(character: character)
    }
}
