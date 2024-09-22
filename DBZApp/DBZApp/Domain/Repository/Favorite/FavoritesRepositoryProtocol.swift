//
//  FavoritesRepositoryProtocol.swift
//  DBZApp
//
//  Created by Uri on 22/9/24.
//

import Foundation

protocol FavoritesRepositoryProtocol {
    var savedFavorites: Published<[FavoriteEntity]>.Publisher { get }
    func updateFavorite(character: Character)
}
