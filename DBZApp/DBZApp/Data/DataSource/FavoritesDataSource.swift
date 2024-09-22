//
//  FavoritesDataSource.swift
//  DBZApp
//
//  Created by Uri on 22/9/24.
//

import Foundation
import CoreData

final class FavoritesDataSource {
    
    private let container: NSPersistentContainer
    private let containerName: String = "FavoritesContainer"
    private let entityName: String = "FavoriteEntity"
    
    @Published var savedEntities: [FavoriteEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                debugPrint("Error loading Core Data: \(error)")
            }
            self.getFavorites()
        }
    }
    
    func updateFavorite(character: Character) {
        if let entity = savedEntities.first(where: { $0.characterId == Int64(character.id) }) {
            delete(entity: entity)
        } else {
            add(character: character)
        }
    }
    
    private func getFavorites() {
        let request = NSFetchRequest<FavoriteEntity>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            debugPrint("Error fetching Favorite Entities: \(error)")
        }
    }
    
    private func add(character: Character) {
        let entity = FavoriteEntity(context: container.viewContext)
        entity.characterId = Int64(character.id)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            debugPrint("Error saving to Core Data: \(error)")
        }
    }
    
    private func delete(entity: FavoriteEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func applyChanges() {
        save()
        getFavorites()
    }
}
