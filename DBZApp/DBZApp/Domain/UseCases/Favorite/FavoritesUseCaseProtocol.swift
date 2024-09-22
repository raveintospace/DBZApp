//
//  FavoritesUseCaseProtocol.swift
//  DBZApp
//
//  Created by Uri on 22/9/24.
//

import Foundation

protocol FavoritesUseCaseProtocol {
    var favoritesPublisher: Published<[FavoriteEntity]>.Publisher { get }
    func updateFavorite(character: Character)
}
