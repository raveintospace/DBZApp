//
//  FavoritesRepositoryImpl.swift
//  DBZApp
//
//  Created by Uri on 22/9/24.
//

import Foundation

final class FavoritesRepositoryImpl: FavoritesRepositoryProtocol {
    private let dataSource: FavoritesDataSource
    
    init(dataSource: FavoritesDataSource) {
        self.dataSource = dataSource
    }
    
    var savedFavorites: Published<[FavoriteEntity]>.Publisher {
        return dataSource.$savedEntities
    }
    
    func updateFavorite(character: Character) {
        dataSource.updateFavorite(character: character)
    }
}
